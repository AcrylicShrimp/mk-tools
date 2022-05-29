local ui = require('scripts/ui')

mk.Entity.build {
    name = "camera",
    camera = {
        order = 0
    }
};

local test_button = ui.createButton('test', 100, 30, 'Click me!')
test_button.button.transform.position = {
    x = 0,
    y = 100
};

local normal = mk.SpriteNinePatch.load("button")
local hover = mk.SpriteNinePatch.load("button_hover")
local down = mk.SpriteNinePatch.load("button_down")

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

test_button.button:listen("mouse-enter", function()
    test_button.button.nine_patch_renderer.nine_patch = hover
end)

test_button.button:listen("mouse-exit", function()
    test_button.button.nine_patch_renderer.nine_patch = normal
end)

test_button.button:listen("mouse-down", function(event)
    test_button.button.nine_patch_renderer.nine_patch = down
end)

test_button.button:listen("mouse-up", function(event)
    test_button.button.nine_patch_renderer.nine_patch = hover
end)
