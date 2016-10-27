-- modelyolo, mutation and state were stolen from robacarps hammerspoon here\
-- https://github.com/robacarp/config_files/blob/master/.hammerspoon/init.lua
--
--
-- modalyolo keeps track of bindings and allows us to wrap all events
ModalYoLo = {}
function ModalYoLo:new(mod_key, modal_key)
  local obby = {
    binding = hs.hotkey.modal.new(mod_key, modal_key)
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
    ratio   = math.floor(hs.window.focusedWindow():screen():fullFrame().w/hs.window.focusedWindow():screen():fullFrame().h)
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




