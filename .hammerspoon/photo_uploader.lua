local path = os.getenv("HOME") .. "/Pictures/Scrns/"
local mkgif_path = os.getenv("HOME") .. "/bin/mkgif"

local function file_exists(name)
   local f=io.open(name, "r")
   if f~=nil then io.close(f) return true else return false end
end

local function has_ext(file, extension)
  return file:sub(-#extension) == extension
end

local function starts_with(file, part)
  return file:sub(#part) == part
end

local function ignore_file(file, flag)
  if file==nil then return true end

  if has_ext(file, ".DS_Store") then return true end
  if starts_with(file, path .. ".") then return true end

  if not file_exists(file) then return true end

  if flag["itemCreated"] then return false end
  if flag["itemRenamed"] then return false end

  return true
end

local function path_processor(files, flags, filter)
  local index = 0
  local count = #files

  return function()
    index = index + 1

    local file = files[index]
    local flag = flags[index]
    while filter(file, flag) do
      index = index + 1
      if (index > count) then return end
      file = files[index]
      flag = flags[index]
      if (file==nil) then return end
    end

    if (index <= count) then
      return file, flag
    end
  end
end



function url_encode(str)
   if str then
      str = str:gsub("\n", "\r\n")
      str = str:gsub("([^%w %/% %-%_%.%~])", function(c)
         return ("%%%02X"):format(string.byte(c))
      end)
      str = str:gsub(" ", "%%20")
   end
   return str
end

local function copy_image_to_clipboard(file)
  local image = hs.image.imageFromPath(file)
  print("file://" .. url_encode(file))

  hs.pasteboard.writeObjects({ url = "file://" .. url_encode(file) })

  hs.notify.new({
    title = "Image copied",
    subTitle = file,
    contentImage = image
  }):send()
end


local function mkgif_callback(temp_file, gif_file)
  local function rm_temp(exit, stdout, stderr)
    hs.task.new("/bin/rm", nil, { temp_file })
  end

  return function(exitcode, stdout, stderr)
    print("mkgif callback " .. exitcode .. " stdout: " .. stdout .. " stderr: " .. stderr)

    hs.task.new("/bin/cp", rm_temp, { temp_file, gif_file }):start()
  end
end

local function gif_maker(file)
  local gif_name = string.gsub(file, "(.mov)$", ".gif")
  local temp_file = os.tmpname()
  local args = {
    file,
    temp_file
  }

  print(hs.inspect(args))

  hs.task.new(mkgif_path, mkgif_callback(temp_file, gif_name), args):start()
end

function photo_uploader(files, flags)
  for file,file_flags in path_processor(files, flags, ignore_file) do
    print(file)
    print(hs.inspect(file_flags))

    if not has_ext(file, ".mov") then
      copy_image_to_clipboard(file)
    else
      gif_maker(file)
    end
  end
end

hs.pathwatcher.new(path, photo_uploader):start()
