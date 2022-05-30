
local font_scale = 5
local table = {}

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
            scale = {
                x = 1 / font_scale,
                y = 1 / font_scale
            }
        },
        ui_element = {
            is_interactible = false,
            order_index = order_index + 1
        },
        glyph_renderer = {
            order = order_index + 1,
            color = mk.Color.black(),
            shader = mk.Shader.load("glyph"),
            font = mk.Font.load("neodgm"),
            font_size = font_size * font_scale,
            config = {
                max_width = width * font_scale,
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
