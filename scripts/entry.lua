local ui = require('scripts/ui')

mk.Entity.build {
    name = "camera",
    camera = {
        order = 0
    }
};

local test_button = ui.createButton('test', 200, 60, 'Click me!')
