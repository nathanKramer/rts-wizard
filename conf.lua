function love.conf(t)
  t.identity = 'saves'               -- The name of the save directory (string)
  t.version = "0.10.1"                -- The LÖVE version this game was made for (string)
  t.console = true                   -- Attach a console (boolean, Windows only)

  t.window.title = "RTS Wizard"         -- The window title (string)
  t.author = 'Nathan'          -- Author (string)
  t.window.icon = nil                -- Filepath to an image to use as the window's icon (string)
  t.window.width = 800               -- The window width (number)
  t.window.height = 600              -- The window height (number)
  t.window.borderless = true        -- Remove all border visuals from the window (boolean)
  t.window.resizable = false         -- Let the window be user-resizable (boolean)
  t.window.minwidth = 1              -- Minimum window width if the window is resizable (number)
  t.window.minheight = 1             -- Minimum window height if the window is resizable (number)
  t.window.fullscreen = false        -- Enable fullscreen (boolean)
  t.window.fullscreentype = "desktop" -- Standard fullscreen or desktop fullscreen mode (string)
  t.window.vsync = true              -- Enable vertical sync (boolean)
  t.window.fsaa = 4                  -- The number of samples to use with multi-sampled antialiasing (number)
  t.window.display = 1               -- Index of the monitor to show the window in (number)

  t.modules.audio = true             -- Enable the audio module (boolean)
  t.modules.event = true             -- Enable the event module (boolean)
  t.modules.graphics = true          -- Enable the graphics module (boolean)
  t.modules.image = true             -- Enable the image module (boolean)
  t.modules.joystick = false         -- Enable the joystick module (boolean)
  t.modules.keyboard = true          -- Enable the keyboard module (boolean)
  t.modules.math = true              -- Enable the math module (boolean)
  t.modules.mouse = true             -- Enable the mouse module (boolean)
  t.modules.physics = false          -- Disable the physics module (boolean) (Not using this for now)
  t.modules.sound = true             -- Enable the sound module (boolean)
  t.modules.system = true            -- Enable the system module (boolean)
  t.modules.timer = true             -- Enable the timer module (boolean)
  t.modules.window = true            -- Enable the window module (boolean)
end