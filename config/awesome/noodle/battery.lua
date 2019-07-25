local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Configuration
local update_interval = 30            -- in seconds

local battery = wibox.widget{
    text = "battery widget",
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local myPopup = awful.popup {
    widget = {
        {
            {
                text   = 'foobar',
                widget = wibox.widget.textbox
            },
            {
                {
                    text   = 'foobar',
                    widget = wibox.widget.textbox
                },
                bg     = '#ff00ff',
                clip   = true,
                shape  = gears.shape.rounded_bar,
                widget = wibox.widget.background
            },
            {
                value         = 0.5,
                forced_height = 30,
                forced_width  = 100,
                widget        = wibox.widget.progressbar
            },
            layout = wibox.layout.fixed.vertical,
        },
        margins = 10,
        widget  = wibox.container.margin
    },
    ontop = true, 
    visible = false,
    type = "popup_menu",
    minimum_width = 200,
    minimum_height = 100,
    hide_on_right_click = true
}

-- Mouse control
 battery:buttons(gears.table.join(
      
     awful.button({ }, 1, function ()
	     -- To show it
	     if myPopup.visible == true then
		     myPopup.visible = false
	     else
		     myPopup.visible = true
	     end
	     myPopup:move_next_to(mouse.current_widget_geometry)
	     myPopup.x = myPopup.x + 120
     end),
      
     awful.button({ }, 2, function () 
     end),
      
     awful.button({ }, 3, function () 
     end),
      
     awful.button({ }, 4, function () 
     end),
     awful.button({ }, 5, function () 
     end)
 ))

local function update_widget(bat)
  battery.markup = bat .. "%"
end

local bat_script = [[
  bash -c '
  upower -i $(upower -e | grep BAT) | grep percentage
  ']]

awful.widget.watch(bat_script, update_interval, function(widget, stdout)
                     local bat = stdout:match(':%s*(.*)..')
                     -- bat = string.gsub(bat, '^%s*(.-)%s*$', '%1')
                     update_widget(bat)
end)

return battery
