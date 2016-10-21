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

  -- automatically disable modal key after 5 seconds
  function obby.binding:entered()
    hs.timer.doAfter(5, function()
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
    frame   = hs.window.focusedWindow():screen():fullFrame(),
    ratio   =  math.floor(hs.window.focusedWindow():screen():fullFrame().w/hs.window.focusedWindow():screen():fullFrame().h)
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

-- Keys for screen resize are laid out as the following:
-- [ q | w  e  r | t ]
-- [ a | s (d) f | g ]
-- [ z | x  c  v | b ]
--
-- The modal keys that I use are:
-- - f6 for half sized windows
-- - f5 for half, third columns for an ultrawide monitor

primary_modal = ModalYoLo:new('f5')

-- UW : Top Left 1/2 Tall 2/3 Wide
-- SQ : Top Left 1/2 Tall 1/2 Wide
primary_modal:bind('q', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(0):y(0):w((mutator.frame.w/3)*2):h(mutator.frame.h/2):commit()
  else
    mutator:x(0):y(0):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
  end
end)

-- UW : Full Left 1 Tall 2/3 Wide
-- SQ : Full Left 1 Tall 1/2 Wide
primary_modal:bind('a', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(0):y(0):w((mutator.frame.w/3)*2):h(mutator.frame.h):commit()
  else
    mutator:x(0):y(0):w(mutator.frame.w/2):h(mutator.frame.h):commit()
  end
end)

-- UW : Bottom Left 1/2 Tall 2/3 Wide
-- SQ : Bottom Left 1/2 Tall 1/2 Wide
primary_modal:bind('z', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(0):y(mutator.frame.h/2):w((mutator.frame.w/3)*2):h(mutator.frame.h/2):commit()
  else
    mutator:x(0):y(mutator.frame.h/2):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
  end
end)


-- UW : Top Left 1/2 Tall 1/3 Wide
-- SQ : Top Left 80% Tall 80% Wide
primary_modal:bind('w', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(0):y(0):w(mutator.frame.w/3):h(mutator.frame.h/2):commit()
  else
    mutator:x(0):y(0):w(mutator.frame.w - 150):h(mutator.frame.h - 150):commit()
  end
end)

-- UW : Full Left 1 Tall 1/3 Wide
-- SQ : Full Left 1 Tall 80% Wide
primary_modal:bind('s', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(0):y(0):w(mutator.frame.w/3):h(mutator.frame.h):commit()
  else
    mutator:x(0):y(0):w(mutator.frame.w - 150):h(mutator.frame.h):commit()
  end
end)

-- UW : Bottom Left 1/2 Tall 1/3 Wide
-- SQ : Bottom Left 80% Tall 80% Wide
primary_modal:bind('x', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(0):y(mutator.frame.h/2):w(mutator.frame.w/3):h(mutator.frame.h/2):commit()
  else
    mutator:x(0):y(150):w(mutator.frame.w - 150):h(mutator.frame.h - 150):commit()
  end
end)


-- UW : Top Center 1/2 Tall 1/3 Wide
-- SQ : Top Center 80% Tall 1   Wide
primary_modal:bind('e', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(mutator.frame.w/3):y(0):w(mutator.frame.w/3):h(mutator.frame.h/2):commit()
  else
    mutator:x(0):y(0):w(mutator.frame.w):h(mutator.frame.h - 150):commit()
  end
end)

-- UW : Full Center 1 Tall 1/3 Wide
-- SQ : Full Center 1 Tall 1   Wide
primary_modal:bind('d', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(mutator.frame.w/3):y(0):w(mutator.frame.w/3):h(mutator.frame.h):commit()
  else
    mutator:x(0):y(0):w(mutator.frame.w):h(mutator.frame.h):commit()
  end
end)

-- UW : Bottom Center 1/2 Tall 1/3 Wide
-- SQ : Bottom Center 80% Tall 1   Wide
primary_modal:bind('c', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(mutator.frame.w/3):y(mutator.frame.h/2):w(mutator.frame.w/3):h(mutator.frame.h/2):commit()
  else
    mutator:x(0):y(150):w(mutator.frame.w):h(mutator.frame.h - 150):commit()
  end
end)


-- UW : Top Right 1/2 Tall 1/3 Wide
-- SQ : Top Right 80% Tall 80% Wide
primary_modal:bind('r', function(mutator)
  if mutator.ratio == 2 then
    mutator:x((mutator.frame.w/3)*2):y(0):w(mutator.frame.w/3):h(mutator.frame.h/2):commit()
  else
    mutator:x(150):y(0):w(mutator.frame.w - 150):h(mutator.frame.h - 150):commit()
  end
end)

-- UW : Full Right 1 Tall 1/3 Wide
-- SQ : Full Right 1 Tall 80% Wide
primary_modal:bind('f', function(mutator)
  if mutator.ratio == 2 then
    mutator:x((mutator.frame.w/3)*2):y(0):w(mutator.frame.w/3):h(mutator.frame.h):commit()
  else
    mutator:x(150):y(0):w(mutator.frame.w - 150):h(mutator.frame.h):commit()
  end
end)

-- UW : Bottom Right 1/2 Tall 1/3 Wide
-- SQ : Bottom Right 80% Tall 80% Wide
primary_modal:bind('v', function(mutator)
  if mutator.ratio == 2 then
    mutator:x((mutator.frame.w/3)*2):y(mutator.frame.h/2):w(mutator.frame.w/3):h(mutator.frame.h/2):commit()
  else
    mutator:x(150):y(150):w(mutator.frame.w - 150):h(mutator.frame.h - 150):commit()
  end
end)


-- UW : Top Right 1/2 Tall 2/3 Wide
-- SQ : Top Right 1/2 Tall 1/2 Wide
primary_modal:bind('t', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(mutator.frame.w/3):y(0):w((mutator.frame.w/3)*2):h(mutator.frame.h/2):commit()
  else
    mutator:x(mutator.frame.w/2):y(0):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
  end
end)

-- UW : Full Right 1 Tall 2/3 Wide
-- SQ : Full Right 1 Tall 1/2 Wide
primary_modal:bind('g', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(mutator.frame.w/3):y(0):w((mutator.frame.w/3)*2):h(mutator.frame.h):commit()
  else
    mutator:x(mutator.frame.w/2):y(0):w(mutator.frame.w/2):h(mutator.frame.h):commit()
  end
end)

-- UW : Bottom Right 1/2 Tall 2/3 Wide
-- SQ : Bottom Right 1/2 Tall 1/2 Wide
primary_modal:bind('b', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(mutator.frame.w/3):y(mutator.frame.h/2):w((mutator.frame.w/3)*2):h(mutator.frame.h/2):commit()
  else
    mutator:x(mutator.frame.w/2):y(mutator.frame.h/2):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
  end
end)


secondary_modal = ModalYoLo:new('f6')

-- UW : Top Left 1/2 Tall 3/4 Wide
-- SQ : Top Left 1/2 Tall 1/2 Wide
secondary_modal:bind('q', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(0):y(0):w((mutator.frame.w/4)*3):h(mutator.frame.h/2):commit()
  else
    mutator:x(0):y(0):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
  end
end)

-- UW : Full Left 1 Tall 3/4 Wide
-- SQ : Full Left 1 Tall 1/2 Wide
secondary_modal:bind('a', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(0):y(0):w((mutator.frame.w/4)*3):h(mutator.frame.h):commit()
  else
    mutator:x(0):y(0):w(mutator.frame.w/2):h(mutator.frame.h):commit()
  end
end)

-- UW : Bottom Left 1/2 Tall 3/4 Wide
-- SQ : Bottom Left 1/2 Tall 1/2 Wide
secondary_modal:bind('z', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(0):y(mutator.frame.h/2):w((mutator.frame.w/4)*3):h(mutator.frame.h/2):commit()
  else
    mutator:x(0):y(mutator.frame.h/2):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
  end
end)


-- UW : Top Left 1/2 Tall 1/4 Wide
-- SQ : Top Left 80% Tall 80% Wide
secondary_modal:bind('w', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(0):y(0):w(mutator.frame.w/4):h(mutator.frame.h/2):commit()
  else
    mutator:x(0):y(0):w(mutator.frame.w - 150):h(mutator.frame.h - 150):commit()
  end
end)

-- UW : Full Left 1 Tall 1/4 Wide
-- SQ : Full Left 1 Tall 80% Wide
secondary_modal:bind('s', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(0):y(0):w(mutator.frame.w/4):h(mutator.frame.h):commit()
  else
    mutator:x(0):y(0):w(mutator.frame.w - 150):h(mutator.frame.h):commit()
  end
end)

-- UW : Bottom Left 1/2 Tall 1/4 Wide
-- SQ : Bottom Left 80% Tall 80% Wide
secondary_modal:bind('x', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(0):y(mutator.frame.h/2):w(mutator.frame.w/4):h(mutator.frame.h/2):commit()
  else
    mutator:x(0):y(150):w(mutator.frame.w - 150):h(mutator.frame.h - 150):commit()
  end
end)


-- UW : Top Center 1/2 Tall 1/2 Wide
-- SQ : Top Center 80% Tall 1   Wide
secondary_modal:bind('e', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(mutator.frame.w/4):y(0):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
  else
    mutator:x(0):y(0):w(mutator.frame.w):h(mutator.frame.h - 150):commit()
  end
end)

-- UW : Full Center 1 Tall 1/2 Wide
-- SQ : Full Center 1 Tall 1   Wide
secondary_modal:bind('d', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(mutator.frame.w/4):y(0):w(mutator.frame.w/2):h(mutator.frame.h):commit()
  else
    mutator:x(0):y(0):w(mutator.frame.w):h(mutator.frame.h):commit()
  end
end)

-- UW : Bottom Center 1/2 Tall 1/2 Wide
-- SQ : Bottom Center 80% Tall 1   Wide
secondary_modal:bind('c', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(mutator.frame.w/4):y(mutator.frame.h/2):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
  else
    mutator:x(0):y(150):w(mutator.frame.w):h(mutator.frame.h - 150):commit()
  end
end)


-- UW : Top Right 1/2 Tall 1/4 Wide
-- SQ : Top Right 80% Tall 80% Wide
secondary_modal:bind('r', function(mutator)
  if mutator.ratio == 2 then
    mutator:x((mutator.frame.w/4)*3):y(0):w(mutator.frame.w/4):h(mutator.frame.h/2):commit()
  else
    mutator:x(150):y(0):w(mutator.frame.w - 150):h(mutator.frame.h - 150):commit()
  end
end)

-- UW : Full Right 1 Tall 1/4 Wide
-- SQ : Full Right 1 Tall 80% Wide
secondary_modal:bind('f', function(mutator)
  if mutator.ratio == 2 then
    mutator:x((mutator.frame.w/4)*3):y(0):w(mutator.frame.w/4):h(mutator.frame.h):commit()
  else
    mutator:x(150):y(0):w(mutator.frame.w - 150):h(mutator.frame.h):commit()
  end
end)

-- UW : Bottom Right 1/2 Tall 1/4 Wide
-- SQ : Bottom Right 80% Tall 80% Wide
secondary_modal:bind('v', function(mutator)
  if mutator.ratio == 2 then
    mutator:x((mutator.frame.w/4)*3):y(mutator.frame.h/2):w(mutator.frame.w/4):h(mutator.frame.h/2):commit()
  else
    mutator:x(150):y(150):w(mutator.frame.w - 150):h(mutator.frame.h - 150):commit()
  end
end)


-- UW : Top Right 1/2 Tall 3/4 Wide
-- SQ : Top Right 1/2 Tall 1/2 Wide
secondary_modal:bind('t', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(mutator.frame.w/4):y(0):w((mutator.frame.w/4)*3):h(mutator.frame.h/2):commit()
  else
    mutator:x(mutator.frame.w/2):y(0):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
  end
end)

-- UW : Full Right 1 Tall 3/4 Wide
-- SQ : Full Right 1 Tall 1/2 Wide
secondary_modal:bind('g', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(mutator.frame.w/4):y(0):w((mutator.frame.w/4)*3):h(mutator.frame.h):commit()
  else
    mutator:x(mutator.frame.w/2):y(0):w(mutator.frame.w/2):h(mutator.frame.h):commit()
  end
end)

-- UW : Bottom Right 1/2 Tall 3/4 Wide
-- SQ : Bottom Right 1/2 Tall 1/2 Wide
secondary_modal:bind('b', function(mutator)
  if mutator.ratio == 2 then
    mutator:x(mutator.frame.w/4):y(mutator.frame.h/2):w((mutator.frame.w/4)*3):h(mutator.frame.h/2):commit()
  else
    mutator:x(mutator.frame.w/2):y(mutator.frame.h/2):w(mutator.frame.w/2):h(mutator.frame.h/2):commit()
  end
end)


-- And finally let me know that you are all loaded
hs.alert.show("Config loaded <3")
