require "table_print"
require "window_resize"

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


-- Debugging mouse positions
--icon = hs.menubar.new()
--icon:setTitle("MP: ")

--hs.timer.doEvery(0.5, function()
--  mouse = hs.mouse.getAbsolutePosition()

--  icon:setTitle("MP: " .. mouse.x .. " " .. mouse.y .. "")
--end)


-- {
--   [ modifier_key ] = {
--     [ screen_ratio ] = {
--       [ key ] = { Mutator Function Name, Width Ratio, Height Ratio }
--     }
--   }
-- }
modal_setup = {
  [ { '', 'f5' } ] = {
    [ 1 ] = {
      q = { 'TL', 1/2, 1/2 }, w = { 'TL', 9/10, 8/10 }, e = { 'T' , 1   , 8/10 }, r = { 'TR', 9/10, 8/10 }, t = { 'TR', 1/2, 1/2 },
      a = { 'L' , 1/2,   1 }, s = { 'L' , 9/10,  1   }, d = { 'C' , 1   ,  1   }, f = { 'R' , 9/10,  1   }, g = { 'R' , 1/2,  1  },
      z = { 'BL', 1/2, 1/2 }, x = { 'BL', 9/10, 8/10 }, c = { 'B' , 1   , 8/10 }, v = { 'BR', 9/10, 8/10 }, b = { 'BR', 1/2, 1/2 }
    },
    [ 2 ] = {
      q = { 'TL', 2/3, 1/2 }, w = { 'TL', 1/3 , 1/2  }, e = { 'TC', 1/3 , 1/2  }, r = { 'TR', 1/3 , 1/2  }, t = { 'TR', 2/3, 1/2 },
      a = { 'L' , 2/3,  1  }, s = { 'L' , 1/3 ,  1   }, d = { 'C' , 1/3 ,  1   }, f = { 'R' , 1/3 ,  1   }, g = { 'R' , 2/3,  1  },
      z = { 'BL', 2/3, 1/2 }, x = { 'BL', 1/3 , 1/2  }, c = { 'BC', 1/3 , 1/2  }, v = { 'BR', 1/3 , 1/2  }, b = { 'BR', 2/3, 1/2 }
    }
  },
  [ { '', 'f6' } ] = {
    [ 1 ] = {
                                                        e = { 'T' ,  1  , 1/2  },
                                                        d = { 'C' , 9/10, 8/10 },
                                                        c = { 'B' ,  1  , 1/2  }
    },
    [ 2 ] = {
      q = { 'TL', 3/4, 1/2 }, w = { 'TL', 1/4 , 1/2  }, e = { 'TC', 1/2 , 1/2  }, r = { 'TR', 1/4 , 1/2  }, t = { 'TR', 3/4, 1/2 },
      a = { 'L' , 3/4,  1  }, s = { 'L' , 1/4 ,  1   }, d = { 'C' , 1/2 ,  1   }, f = { 'R' , 1/4 ,  1   }, g = { 'R' , 3/4,  1  },
      z = { 'BL', 3/4, 1/2 }, x = { 'BL', 1/4 , 1/2  }, c = { 'BC', 1/2 , 1/2  }, v = { 'BR', 1/4 , 1/2  }, b = { 'BR', 3/4, 1/2 }
    }
  }
}

mutators = {}
function mutators.TL(window, width_ratio, height_ratio)
  window
    :x(0)
    :y(0)
    :w( window.frame.w * width_ratio )
    :h( window.frame.h * height_ratio )
end

function mutators.L(window, width_ratio, height_ratio)
  window
    :x(0)
    :y(0)
    :w( window.frame.w * width_ratio )
    :h( window.frame.h )
end

function mutators.BL(window, width_ratio, height_ratio)
  window
    :x(0)
    :y( window.frame.h * (1 - height_ratio) )
    :w( window.frame.w * width_ratio )
    :h( window.frame.h * height_ratio )
end


function mutators.T(window, width_ratio, height_ratio)
  window
    :x(0)
    :y(0)
    :w( window.frame.w )
    :h( window.frame.h * height_ratio )
end

function mutators.TC(window, width_ratio, height_ratio)
  window
    :x( (window.frame.w * (1 - width_ratio)) / 2 )
    :y(0)
    :w( window.frame.w * width_ratio )
    :h( window.frame.h * height_ratio )
end

function mutators.C(window, width_ratio, height_ratio)
  window
    :x( (window.frame.w * (1 - width_ratio)) / 2 )
    :y( (window.frame.h * (1 - height_ratio)) / 2 )
    :w( window.frame.w * width_ratio )
    :h( window.frame.h * height_ratio )
end

function mutators.BC(window, width_ratio, height_ratio)
  window
    :x( (window.frame.w * (1 - width_ratio)) / 2 )
    :y( window.frame.h * (1 - height_ratio) )
    :w( window.frame.w * width_ratio )
    :h( window.frame.h * height_ratio )
end

function mutators.B(window, width_ratio, height_ratio)
  window
    :x(0)
    :y( window.frame.h * (1 - height_ratio) )
    :w( window.frame.w )
    :h( window.frame.h * height_ratio )
end


function mutators.TR(window, width_ratio, height_ratio)
  window
    :x( window.frame.w * (1 - width_ratio) )
    :y(0)
    :w( window.frame.w * width_ratio )
    :h( window.frame.h * height_ratio )
end

function mutators.R(window, width_ratio, height_ratio)
  window
    :x( window.frame.w * (1 - width_ratio) )
    :y( window.frame.h * (1 - height_ratio) )
    :w( window.frame.w * width_ratio )
    :h( window.frame.h * height_ratio )
end

function mutators.BR(window, width_ratio, height_ratio)
  window
    :x( window.frame.w * (1 - width_ratio) )
    :y( window.frame.h * (1 - height_ratio) )
    :w( window.frame.w * width_ratio )
    :h( window.frame.h * height_ratio )
end


for modal_key, modal_settings in pairs(modal_setup) do
  local modal = ModalYoLo:new(table.unpack(modal_key))

  -- Reformats our modal setup to be a bit easier to work with below
  local keys = {}
  for ratio, key_settings in pairs(modal_settings) do
    for key, window_settings in pairs(key_settings) do
      if keys[key] == nil then
        keys[ key ] = {}
      end

      keys[ key ][ ratio ] = window_settings
    end
  end

  -- print(table.show(keys))

  -- Setup all of our actual key bindings
  for key, settings in pairs(keys) do
    modal:bind(key, function(window)
      window_settings = settings[ window.ratio ]

      mutator_function, width_ratio, height_ratio = table.unpack( window_settings )

      mutators[ mutator_function ]( window, width_ratio, height_ratio )

      window:commit()
    end)
  end
end

-- And finally let me know that you are all loaded
hs.alert.show("Config loaded <3")
