-- hashtag automatic reload
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == '.lua' then
      doReload = true
    end
  end

  if doReload then
    hs.reload()
  end
end
hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfig):start()

-- okay, seriously now.
onlyScreenChangeOnce = false
function clearOnlyScreenChangeOnce()
  onlyScreenChangeOnce = false
end

function onScreenChange()
  if onlyScreenChangeOnce then
    return
  end

  hs.alert.show("Screen resize </3")
  onlyScreenChangeOnce = true

  hs.timer.new(hs.timer.seconds(5), clearOnlyScreenChangeOnce)
end
hs.screen.watcher.new(onScreenChange):start()

hs.window.animationDuration = 0
hs.window.setFrameCorrectness = true

-- modelyolo, mutation and state were stolen from robacarps hammerspoon here\
-- https://github.com/robacarp/config_files/blob/master/.hammerspoon/init.lua
--
--
-- modalyolo keeps track of bindings and allows us to wrap all events
ModalYoLo = {}
function ModalYoLo:new(modal_key)
  local obby = {
    binding = hs.hotkey.modal.new('',modal_key)
  }

  -- disable binding on escape key
  obby.binding:bind('', 'escape', function()
    obby.binding:exit()
  end)

  -- automatically disable modal key after 1 second
  function obby.binding:entered()
    hs.timer.doAfter(1, function()
      obby.binding:exit()
    end)
  end

  self.__index = self
  return setmetatable(obby, self)
end

  -- bind a key to an action under the modal
  function ModalYoLo:bind(key, mutator)
    self.binding:bind('', key, function()
      self.binding:exit()
      mutator(Mutation:new())
    end)
  end

-- a mutation object is what allows chainable transforms
Mutation = {}
function Mutation:new()
  local obby = {
    frame_x = 0,
    frame_y = 0,
    frame_w = 1000,
    frame_h = 1000,
    screen  = hs.screen.mainScreen():fullFrame(),
    window  = hs.window.focusedWindow()
  }

  self.__index = self
  return setmetatable(obby, self)
end

  function Mutation:debug()
   -- hs.alert.show(
    --   "Heights: frame:" .. scr:frame().h .. ", fullFrame:" .. scr:fullFrame().h .. "\n" ..
    --   "\tframe / fullFrame:" .. scr:frame().h / scr:fullFrame().h
    -- )

    hs.alert.show(
      "X / Y: " .. self.frame_x .. ", " .. self.frame_y .. "\n" ..
      "W / H: " .. self.frame_w .. ", " .. self.frame.h
    , 3)
  end

  function Mutation:x(ex)
    self.frame_x = ex
    return self
  end

  function Mutation:y(ey)
    self.frame_y = ey
    return self
  end

  function Mutation:h(eh)
    self.frame_h = eh
    return self
  end

  function Mutation:w(ew)
    self.frame_w = ew
    return self
  end

  function Mutation:adjust_frame()
    screen = hs.screen.mainScreen()
    local y_offset = screen:fullFrame().h - screen:frame().h
    local x_offset = screen:fullFrame().w - screen:frame().w

    h_multiplier = screen:frame().h / screen:fullFrame().h
    w_multiplier = screen:frame().w / screen:fullFrame().w

    self.frame_x = self.frame_x * w_multiplier + x_offset
    self.frame_y = self.frame_y * h_multiplier + y_offset
    self.frame_w = self.frame_w * w_multiplier
    self.frame_h = self.frame_h * h_multiplier
  end

  function Mutation:commit()
    self:adjust_frame()
    self.window:setFrame(self:buildFrame())
  end

  function Mutation:buildFrame()
    return hs.geometry(
      self.frame_x,
      self.frame_y,
      self.frame_w,
      self.frame_h
    )
  end

-- Keys for screen resize are generally laid out as the following:
-- [ e r t ]
-- [ d f g ]
-- [ c v b ]
-- Where each letter represents the area that the window will take up, eg
-- `r` will put the window to full width and dock it to the top of the screen,
-- with the given modal keys height function. `e` will dock the window to the
-- top left corner and the width and height will both be taken from the modal
-- key.
--
-- The modal keys that I use are:
-- - f6 for half sized windows
-- - f5 for 80% windows

-- Half size modal
half_modal = ModalYoLo:new('f6')

-- Top Left corner
half_modal:bind('e', function(mutator)
  mutator:x(0):y(0):w(mutator.screen.w / 2):h(mutator.screen.h / 2):commit()
end)

-- Top half
half_modal:bind('r', function(mutator)
  mutator:x(0):y(0):w(mutator.screen.w):h(mutator.screen.h / 2):commit()
end)

-- Top Right corner
half_modal:bind('t', function(mutator)
  mutator:x(mutator.screen.w / 2):y(0):w(mutator.screen.w / 2):h(mutator.screen.h / 2):commit()
end)

-- Left half
half_modal:bind('d', function(mutator)
  mutator:x(0):y(0):w(mutator.screen.w / 2):h(mutator.screen.h):commit()
end)

-- Full Screen
half_modal:bind('f', function( mutator)
  mutator:x(0):y(0):w(mutator.screen.w):h(mutator.screen.h):commit()
end)

-- Right half
half_modal:bind('g', function(mutator)
  mutator:x(mutator.screen.w / 2):y(0):w(mutator.screen.w / 2):h(mutator.screen.h):commit()
end)

-- Bottom Left corner
half_modal:bind('c', function(mutator)
  mutator:x(0):y(mutator.screen.h / 2):w(mutator.screen.w / 2):h(mutator.screen.h / 2):commit()
end)

-- Bottom half
half_modal:bind('v', function(mutator)
  mutator:x(0):y(mutator.screen.h / 2):w(mutator.screen.w):h(mutator.screen.h / 2):commit()
end)

-- Bottom Right corner
half_modal:bind('b', function(mutator)
  mutator:x(mutator.screen.w / 2):y(mutator.screen.h / 2):w(mutator.screen.w / 4):h(mutator.screen.h / 4):commit()
end)

-- 80% size modal
eighty_percent_modal = ModalYoLo:new('f5')

-- Top Left corner
eighty_percent_modal:bind('e', function(mutator)
  mutator:x(0):y(0):w(mutator.screen.w - 150):h(mutator.screen.h - 150):commit()
end)

-- Top eighty_percent
eighty_percent_modal:bind('r', function(mutator)
  mutator:x(0):y(0):w(mutator.screen.w):h(mutator.screen.h - 150):commit()
end)

-- Top Right corner
eighty_percent_modal:bind('t', function(mutator)
  mutator:x(150):y(0):w(mutator.screen.w - 150):h(mutator.screen.h - 150):commit()
end)

-- Left eighty_percent
eighty_percent_modal:bind('d', function(mutator)
  mutator:x(0):y(0):w(mutator.screen.w - 150):h(mutator.screen.h):commit()
end)

-- Full Screen
eighty_percent_modal:bind('f', function( mutator)
  mutator:x(150):y(150):w(mutator.screen.w - 300):h(mutator.screen.h - 300):commit()
end)

-- Right eighty_percent
eighty_percent_modal:bind('g', function(mutator)
  mutator:x(150):y(0):w(mutator.screen.w - 150):h(mutator.screen.h):commit()
end)

-- Bottom Left corner
eighty_percent_modal:bind('c', function(mutator)
  mutator:x(0):y(150):w(mutator.screen.w - 150):h(mutator.screen.h - 150):commit()
end)

-- Bottom eighty_percent
eighty_percent_modal:bind('v', function(mutator)
  mutator:x(0):y(150):w(mutator.screen.w):h(mutator.screen.h - 150):commit()
end)

-- Bottom Right corner
eighty_percent_modal:bind('b', function(mutator)
  mutator:x(150):y(150):w(mutator.screen.w - 150):h(mutator.screen.h - 150):commit()
end)


-- And finally let me know that you are all loaded
hs.alert.show("Config loaded <3")
