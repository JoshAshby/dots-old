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
--hs.window.setFrameCorrectness = true

-- modelyolo, mutation and state were stolen from robacarps hammerspoon here\
-- https://github.com/robacarp/config_files/blob/master/.hammerspoon/init.lua
--
--
-- modalyolo keeps track of bindings and allows us to wrap all events
ModalYoLo = {}
function ModalYoLo:new(modal_key)
  local obby = {
    binding = hs.hotkey.modal.new('', modal_key)
  }

  -- disable binding on escape key
  obby.binding:bind('', 'escape', function()
    obby.binding:exit()
  end)

  -- automatically disable modal key after 1 second
  function obby.binding:entered()
    hs.timer.doAfter(2, function()
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
    window  = hs.window.focusedWindow(),
    screen  = hs.window.focusedWindow():screen(),
    frame   = hs.window.focusedWindow():screen():fullFrame()
  }

  self.__index = self
  return setmetatable(obby, self)
end

  function Mutation:debug()
    hs.alert.show(
      "X / Y: " .. self.frame_x .. ", " .. self.frame_y .. "\n" ..
      "W / H: " .. self.frame_w .. ", " .. self.frame_h
    , 3)

    self:commit()
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
    local_frame = hs.window.focusedWindow():screen():frame()
    local y_offset = self.frame.h - local_frame.h
    local x_offset = self.frame.w - local_frame.w

    h_multiplier = local_frame.h / self.frame.h
    w_multiplier = local_frame.w / self.frame.w

    self.frame_x = self.frame_x * w_multiplier + x_offset
    self.frame_y = self.frame_y * h_multiplier + y_offset
    self.frame_w = self.frame_w * w_multiplier
    self.frame_h = self.frame_h * h_multiplier
  end

  function Mutation:commit()
    self:adjust_frame()
    frame = self.screen:localToAbsolute(self:buildFrame())
    self.window:setFrame(frame)
  end

  function Mutation:buildFrame()
    return hs.geometry(
      self.frame_x,
      self.frame_y,
      self.frame_w,
      self.frame_h
    )
  end

-- Debugging mouse positions
--icon = hs.menubar.new()
--icon:setTitle("MP: ")

--hs.timer.doEvery(0.5, function()
--  mouse = hs.mouse.getAbsolutePosition()

--  icon:setTitle("MP: " .. mouse.x .. " " .. mouse.y .. "")
--end)

-- Keys for screen resize are generally laid out as the following:
-- [ q | w  e  r | t ]
-- [ a | s (d) f | g ]
-- [ z | x  c  v | b ]
-- Where each letter represents the area that the window will take up, eg
-- `r` will put the window to full width and dock it to the top of the screen,
-- with the given modal keys height function. `e` will dock the window to the
-- top left corner and the width and height will both be taken from the modal
-- key.
--
-- The modal keys that I use are:
-- - f6 for half sized windows
-- - f5 for half, third columns for an ultrawide monitor

-- Half size modal
half_modal = ModalYoLo:new('f6')

-- Top Left corner
half_modal:bind('w', function(mutator)
  mutator:x(0):y(0):w(mutator.frame.w - 150):h(mutator.frame.h - 150):commit()
end)

-- Top eighty_percent
half_modal:bind('e', function(mutator)
  mutator:x(0):y(0):w(mutator.frame.w):h(mutator.frame.h - 150):commit()
end)

-- Top Right corner
half_modal:bind('r', function(mutator)
  mutator:x(150):y(0):w(mutator.frame.w - 150):h(mutator.frame.h - 150):commit()
end)

-- Left eighty_percent
half_modal:bind('s', function(mutator)
  mutator:x(0):y(0):w(mutator.frame.w - 150):h(mutator.frame.h):commit()
end)

-- Full Screen
half_modal:bind('d', function( mutator)
  mutator:x(150):y(150):w(mutator.frame.w - 300):h(mutator.frame.h - 300):commit()
end)

-- Right eighty_percent
half_modal:bind('f', function(mutator)
  mutator:x(150):y(0):w(mutator.frame.w - 150):h(mutator.frame.h):commit()
end)

-- Bottom Left corner
half_modal:bind('x', function(mutator)
  mutator:x(0):y(150):w(mutator.frame.w - 150):h(mutator.frame.h - 150):commit()
end)

-- Bottom eighty_percent
half_modal:bind('c', function(mutator)
  mutator:x(0):y(150):w(mutator.frame.w):h(mutator.frame.h - 150):commit()
end)

-- Bottom Right corner
half_modal:bind('v', function(mutator)
  mutator:x(150):y(150):w(mutator.frame.w - 150):h(mutator.frame.h - 150):commit()
end)


ultrawide_modal = ModalYoLo:new('f5')

-- Top Left 1/2 Tall 1/2 Wide
ultrawide_modal:bind('q', function(mutator)
  mutator:x(0):y(0):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
end)

-- Full Left 1 Tall 1/2 Wide
ultrawide_modal:bind('a', function(mutator)
  mutator:x(0):y(0):w(mutator.frame.w/2):h(mutator.frame.h):commit()
end)

-- Bottom Left 1/2 Tall 1/2 Wide
ultrawide_modal:bind('z', function(mutator)
  mutator:x(0):y(mutator.frame.h/2):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
end)


-- Top Left 1/2 Tall 1/3 Wide
ultrawide_modal:bind('w', function(mutator)
  mutator:x(0):y(0):w(mutator.frame.w/3):h(mutator.frame.h/2):commit()
end)

-- Full Left 1 Tall 1/3 Wide
ultrawide_modal:bind('s', function(mutator)
  mutator:x(0):y(0):w(mutator.frame.w/3):h(mutator.frame.h):commit()
end)

-- Bottom Left 1/2 Tall 1/3 Wide
ultrawide_modal:bind('x', function(mutator)
  mutator:x(0):y(mutator.frame.h/2):w(mutator.frame.w/3):h(mutator.frame.h/2):commit()
end)


-- Top Center 1/2 Tall 1/3 Wide
ultrawide_modal:bind('e', function(mutator)
  mutator:x(mutator.frame.w/3):y(0):w(mutator.frame.w/3):h(mutator.frame.h/2):commit()
end)

-- Full Center 1 Tall 1/3 Wide
ultrawide_modal:bind('d', function(mutator)
  mutator:x(mutator.frame.w/3):y(0):w(mutator.frame.w/3):h(mutator.frame.h):commit()
end)

-- Bottom Center 1/2 Tall 1/3 Wide
ultrawide_modal:bind('c', function(mutator)
  mutator:x(mutator.frame.w/3):y(mutator.frame.h/2):w(mutator.frame.w/3):h(mutator.frame.h/2):commit()
end)


-- Top Right 1/2 Tall 1/3 Wide
ultrawide_modal:bind('r', function(mutator)
  mutator:x((mutator.frame.w/3)*2):y(0):w(mutator.frame.w/3):h(mutator.frame.h/2):commit()
end)

-- Full Right 1 Tall 1/3 Wide
ultrawide_modal:bind('f', function(mutator)
  mutator:x((mutator.frame.w/3)*2):y(0):w(mutator.frame.w/3):h(mutator.frame.h):commit()
end)

-- Bottom Right 1/2 Tall 1/3 Wide
ultrawide_modal:bind('v', function(mutator)
  mutator:x((mutator.frame.w/3)*2):y(mutator.frame.h/2):w(mutator.frame.w/3):h(mutator.frame.h/2):commit()
end)


-- Top Right 1/2 Tall 1/2 Wide
ultrawide_modal:bind('t', function(mutator)
  mutator:x(mutator.frame.w/2):y(0):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
end)

-- Full Right 1 Tall 1/2 Wide
ultrawide_modal:bind('g', function(mutator)
  mutator:x(mutator.frame.w/2):y(0):w(mutator.frame.w/2):h(mutator.frame.h):commit()
end)

-- Bottom Right 1/2 Tall 1/2 Wide
ultrawide_modal:bind('b', function(mutator)
  mutator:x(mutator.frame.w/2):y(mutator.frame.h/2):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
end)


-- And finally let me know that you are all loaded
hs.alert.show("Config loaded <3")
