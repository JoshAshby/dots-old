function meep
  if test -n "$argv"
    set ip_string "http://"(ipconfig getifaddr en0)":$argv"
  else
    set ip_string "http://"(ipconfig getifaddr en0)
  end

  echo $ip_string | pbcopy
  echo $ip_string
end
