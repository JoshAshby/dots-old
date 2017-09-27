complete -c repos -x -a '(__fish_complete_directories ~/repos/(commandline -ct) | cut -d "/" -f 5-)' --description 'Directory'
