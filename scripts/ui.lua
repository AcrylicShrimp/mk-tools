local table = {}

table.createButton = function(name, width, height, text)
    local button = mk.Entity.build {
        name = name,
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
                x = width / 2 - 400,
                y = height / 2 - 16
            }
        },
        glyph_renderer = {
            order = 1,
            shader = mk.Shader.load("glyph"),
            font = mk.Font.load("neodgm"),
            font_size = 32,
            config = {
                max_width = 800,
                horizontal_align = "center"
            },
            text = text
        }
    }

    return {button, label}
end

return table
