-- hashtag automatic reload
hs.window.animationDuration = 0
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

  hs.alert.show("</3")
  onlyScreenChangeOnce = true

  hs.timer.new(hs.timer.seconds(5), clearOnlyScreenChangeOnce)
end
hs.screen.watcher.new(onScreenChange):start()

-- And finally let me know that you are all loaded
hs.alert.show("<3")
