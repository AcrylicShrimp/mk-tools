
local table = {}

function sampleFontName()
    local fonts = {"온글잎 안될과학유니랩장체", "AppleSDGothicNeoM", "DeogonPrincess", "koverwatch", "neodgm", "Pak_Yong_jun", "Pretendard", "WooridaumR"}
    return fonts[math.random(1, #fonts)]
end

table.createButton = function(name, width, height, text, font_size, order_index)
    local button = mk.Entity.build {
        name = name,
        ui_element = {
            order_index = order_index
        },
        nine_patch_renderer = {
            order = order_index,
            shader = mk.Shader.load("nine-patch"),
            nine_patch = mk.SpriteNinePatch.load("button"),
            color = mk.Color.rgba(1, 1, 1, 1),
            width = width,
            height = height
        }
    }
    local label = mk.Entity.build {
        name = name .. "_label",
        transform = {
            parent = button.transform,
            position = {
                x = 0,
                y = (font_size - height) / 2
            },
            angle = 0
        },
        ui_element = {
            is_interactible = false,
            order_index = order_index + 1
        },
        glyph_renderer = {
            order = order_index + 1,
            color = mk.Color.white(),
            shader = mk.Shader.load("glyph"),
            font = mk.Font.load(sampleFontName()),
            font_size = font_size,
            thickness = 0.45,
            smoothness = 0.2,
            config = {
                max_width = width,
                horizontal_align = "center",
                vertical_align = "middle"
            },
            text = text
        }
    }

    return {
        button = button,
        label = label
    }
end

return table
