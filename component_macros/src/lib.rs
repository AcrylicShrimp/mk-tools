use convert_case::{Case, Casing};
use proc_macro::TokenStream;
use quote::__private::TokenStream as QuoteTokenStream;
use quote::{format_ident, quote, ToTokens};
use syn::parse::Parse;
use syn::token::Comma;
use syn::{parse_macro_input, Data, DeriveInput, Ident, Index, LitStr, Token};

enum FieldRef {
    Ident(Ident),
    Index(Index),
}

impl ToTokens for FieldRef {
    fn to_tokens(&self, tokens: &mut QuoteTokenStream) {
        match self {
            Self::Ident(ident) => ident.to_tokens(tokens),
            Self::Index(index) => index.to_tokens(tokens),
        }
    }
}

#[derive(Debug, Clone, Copy)]
enum AnimatingFieldType {
    Bool,
    Integer,
    Float,
    String,
}

#[derive(Debug)]
struct AnimatingFieldArgument {
    pub ty: AnimatingFieldType,
    pub name: String,
}

impl Parse for AnimatingFieldArgument {
    fn parse(input: syn::parse::ParseStream) -> syn::Result<Self> {
        let mut ty = None;
        let mut name = None;

        while !input.is_empty() {
            let arg_name = input.parse::<Ident>()?;

            if arg_name == "ty" {
                if ty.is_some() {
                    return Err(syn::Error::new(input.span(), "duplicated argument: ty"));
                }

                input.parse::<Token![=]>()?;
                let parsed = input.parse::<LitStr>()?;

                ty = Some(match parsed.value().as_str() {
                    "bool" => AnimatingFieldType::Bool,
                    "integer" => AnimatingFieldType::Integer,
                    "float" => AnimatingFieldType::Float,
                    "string" => AnimatingFieldType::String,
                    ty @ _ => {
                        return Err(syn::Error::new(
                            parsed.span(),
                            format!("invalid argument: type: {}", ty),
                        ));
                    }
                });

                if input.peek(Comma) {
                    input.parse::<Comma>()?;
                }
            } else if arg_name == "name" {
                if name.is_some() {
                    return Err(syn::Error::new(input.span(), "duplicated argument: name"));
                }

                input.parse::<Token![=]>()?;
                let parsed = input.parse::<LitStr>()?;
                name = Some(parsed.value());

                if input.peek(Comma) {
                    input.parse::<Comma>()?;
                }
            } else {
                return Err(syn::Error::new(
                    input.span(),
                    format!("invalid argument: {}", arg_name),
                ));
            }
        }

        let ty = if let Some(ty) = ty {
            ty
        } else {
            return Err(syn::Error::new(input.span(), "missing argument: ty"));
        };

        let name = if let Some(name) = name {
            name
        } else {
            return Err(syn::Error::new(input.span(), "missing argument: name"));
        };

        Ok(Self { ty, name })
    }
}

#[proc_macro_derive(Component, attributes(animate))]
pub fn component_derive(item: TokenStream) -> TokenStream {
    let input = parse_macro_input!(item as DeriveInput);
    let data = if let Data::Struct(data) = input.data {
        data
    } else {
        return TokenStream::new();
    };

    let name = input.ident;
    let name_snake = name.to_string().to_case(Case::Snake);
    let mut field_index = 0;
    let mut fields = vec![];
    let mut tys = vec![];
    let mut matching_tys = vec![];
    let mut matching_as_tys = vec![];
    let mut names = vec![];

    for field in &data.fields {
        for attr in &field.attrs {
            if let Some(ident) = attr.path.get_ident() {
                if ident == "animate" {
                    let argument = attr.parse_args::<AnimatingFieldArgument>().unwrap();

                    match &field.ident {
                        Some(ident) => {
                            fields.push(FieldRef::Ident(ident.clone()));
                        }
                        None => {
                            let index = Index::from(field_index);
                            field_index += 1;
                            fields.push(FieldRef::Index(index));
                        }
                    };

                    tys.push(argument.ty);
                    matching_tys.push(format_ident!(
                        "{}",
                        match argument.ty {
                            AnimatingFieldType::Bool => "bool",
                            AnimatingFieldType::Integer => "i64",
                            AnimatingFieldType::Float => "f64",
                            AnimatingFieldType::String => "String",
                        }
                    ));
                    matching_as_tys.push(format_ident!(
                        "as_{}",
                        match argument.ty {
                            AnimatingFieldType::Bool => "bool",
                            AnimatingFieldType::Integer => "integer",
                            AnimatingFieldType::Float => "float",
                            AnimatingFieldType::String => "string",
                        }
                    ));
                    names.push(argument.name);
                }
            }
        }
    }

    let expanded = quote! {
        impl #name {
            pub fn ty(&self) -> &'static str {
                #name_snake
            }

            pub fn animate(
                &mut self,
                time_line: &mk::animation::AnimationTimeLine,
                key_frame: &mk::animation::AnimationKeyFrame,
                normalized_time_in_key_frame: f32,
            ) {
                match time_line.field.as_str() {
                    #(
                        #names => {
                            self.#fields = <#matching_tys as mk::animation::Interpolatable>::interpolate(
                                key_frame.from.#matching_as_tys(),
                                key_frame.to.#matching_as_tys(),
                                normalized_time_in_key_frame,
                            ) as _;
                        }
                    )*
                    _ => {}
                }
            }
        }
    };

    TokenStream::from(expanded)
}
