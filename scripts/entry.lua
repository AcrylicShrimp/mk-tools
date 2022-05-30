local ui = require('scripts/ui')

mk.Entity.build {
    name = "camera",
    camera = {
        order = 0
    }
};

local normal = mk.SpriteNinePatch.load("button")
local hover = mk.SpriteNinePatch.load("button_hover")
local down = mk.SpriteNinePatch.load("button_down")

function make_button_random(i)
    local button = ui.createButton("button_" .. i, 100, 100, "Button " .. i, 20, i)
    button.button.transform.position = {
        x = math.random(-400, 400),
        y = math.random(-400, 400)
    };
    
    button.button:listen("mouse-enter", function()
        button.button.nine_patch_renderer.nine_patch = hover
    end)
    
    button.button:listen("mouse-exit", function()
        button.button.nine_patch_renderer.nine_patch = normal
    end)
    
    button.button:listen("mouse-down", function(event)
        button.button.nine_patch_renderer.nine_patch = down
    end)
    
    button.button:listen("mouse-up", function(event)
        button.button.nine_patch_renderer.nine_patch = hover
    end)
end

for i = 0, 100 do
    make_button_random(i * 2)
end

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
