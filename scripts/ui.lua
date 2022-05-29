local table = {}

table.createButton = function(name, width, height, text)
    local button = mk.Entity.build {
        name = name,
        ui_element = {
            order_index = 0
        },
        nine_patch_renderer = {
            order = 0,
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
                x = width / 2 - 100,
                y = 8 - height / 2
            },
            scale = {
                x = 0.25,
                y = 0.25
            }
        },
        ui_element = {
            is_interactible = false,
            order_index = 1
        },
        glyph_renderer = {
            order = 1,
            color = mk.Color.black(),
            shader = mk.Shader.load("glyph"),
            font = mk.Font.load("neodgm"),
            font_size = 64,
            config = {
                max_width = 800,
                horizontal_align = "center"
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
