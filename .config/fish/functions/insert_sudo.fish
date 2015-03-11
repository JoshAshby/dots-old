function insert_sudo -d "Inserts sudo at the beginning of the command line"
  set -l cmd_val (commandline)

  commandline --replace "sudo $cmd_val"
end
