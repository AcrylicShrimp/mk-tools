local ui = require('scripts/ui')

mk.Entity.build {
    name = "camera",
    camera = {
        order = 0
    }
};

local root = mk.Entity.build {
    name = "root",
    ui_element = {
        order_index = 0,
        is_interactible = false
    },
    ui_scaler = {
        mode = "stretch",
        reference_size = {
            width = 640,
            height = 480
        }
    }
}

function CreateSideButton(name, anchor, margin, font_size, text)
    local button = mk.Entity.build {
        name = name,
        transform = {
            parent = root.transform
        },
        ui_element = {
            anchor = anchor,
            margin = margin,
            order_index = 1
        },
        nine_patch_renderer = {
            order = 1,
            shader = mk.Shader.load("nine-patch"),
            nine_patch = mk.SpriteNinePatch.load("button"),
            color = mk.Color.rgba(1, 1, 1, 1),
            width = 100,
            height = 100
        }
    }
    local text = mk.Entity.build {
        name = name .. "text",
        transform = {
            parent = button.transform
        },
        ui_element = {
            anchor = {
                min = {
                    x = 0,
                    y = 0
                },
                max = {
                    x = 1,
                    y = 1
                }
            },
            is_interactible = false,
            order_index = 2
        },
        glyph_renderer = {
            order = 2,
            color = mk.Color.white(),
            shader = mk.Shader.load("glyph"),
            font = mk.Font.load("DeogonPrincess"),
            font_size = font_size,
            thickness = 0.5,
            smoothness = 2 / font_size,
            config = {
                horizontal_align = "center",
                vertical_align = "middle"
            },
            text = text
        }
    }

    return {
        button = button,
        text = text
    }
end

local lt = CreateSideButton("lt", {
    min = {
        x = 0,
        y = 0
    },
    max = {
        x = 0,
        y = 0
    }
}, {
    left = 0,
    right = -100,
    top = 0,
    bottom = -100
}, 25, "좌상단")

CreateSideButton("rt", {
    min = {
        x = 1,
        y = 0
    },
    max = {
        x = 1,
        y = 0
    }
}, {
    left = -100,
    right = 0,
    top = 0,
    bottom = -100
}, 25, "우상단")

CreateSideButton("lb", {
    min = {
        x = 0,
        y = 1
    },
    max = {
        x = 0,
        y = 1
    }
}, {
    left = 0,
    right = -100,
    top = -100,
    bottom = 0
}, 25, "좌하단")

CreateSideButton("rb", {
    min = {
        x = 1,
        y = 1
    },
    max = {
        x = 1,
        y = 1
    }
}, {
    left = -100,
    right = 0,
    top = -100,
    bottom = 0
}, 25, "우하단")

-- local normal = mk.SpriteNinePatch.load("button")
-- local hover = mk.SpriteNinePatch.load("button_hover")
-- local down = mk.SpriteNinePatch.load("button_down")

-- function make_button_random(i)
--     local button = ui.createButton("button_" .. i, 150, 100, "Btn " .. i, 26, i)
--     button.button.transform.position = {
--         x = math.random(-400, 400),
--         y = math.random(-400, 400)
--     };

--     button.button:listen("mouse-enter", function()
--         button.button.nine_patch_renderer.nine_patch = hover
--     end)

--     button.button:listen("mouse-exit", function()
--         button.button.nine_patch_renderer.nine_patch = normal
--     end)

--     button.button:listen("mouse-down", function(event)
--         button.button.nine_patch_renderer.nine_patch = down
--     end)

--     button.button:listen("mouse-up", function(event)
--         button.button.nine_patch_renderer.nine_patch = hover
--     end)
-- end

-- for i = 0, 100 do
--     make_button_random(i * 2)
-- end

-- local test_button = ui.createButton('test', 100, 30, 'Click me!', 16, 0)
-- test_button.button.transform.position = {
--     x = 0,
--     y = 100
-- };

-- mk.Event.KeyDown.listen(function(event)
--     print(event.key)
-- end)

-- mk.Event.KeyUp.listen(function(event)
--     print(event.key)
-- end)

-- mk.Event.PointerEnter.listen(function()
--     test_button.button.nine_patch_renderer.nine_patch = hover
-- end)

-- mk.Event.PointerExit.listen(function()
--     test_button.button.nine_patch_renderer.nine_patch = normal
-- end)

-- mk.Event.PointerDown.listen(function(event)
--     if event.button ~= 'left' then
--         return
--     end

--     test_button.button.nine_patch_renderer.nine_patch = down
-- end)

-- mk.Event.PointerUp.listen(function(event)
--     if event.button ~= 'left' then
--         return
--     end

--     test_button.button.nine_patch_renderer.nine_patch = hover
-- end)

-- mk.Event.PointerMove.listen(function(event)
--     print('pointer move', event.pointer_x, event.pointer_y)
-- end)
