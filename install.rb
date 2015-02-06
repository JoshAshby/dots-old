#!/usr/bin/env ruby
require 'fileutils'

overwrite_files = true

home = Dir.home
repo = Dir.pwd

dont_link = {
  all: ['README', 'zsh', '.gitignore', '.gitmodules', '.git', '..', '.', __FILE__],
  osx: ['.conkyrc', '.Xmodmap'],
  linux: ['.slate.js']
}

except = dont_link[:all] + dont_link['linux']

# Well this is messy...
to_link = (Dir.entries('.') - except).map do |dir|
  if Dir.exist?(dir)
    (Dir.entries(dir) - ['..', '.']).map do |di|
      "#{dir}/#{di}"
    end
  else
    dir
  end
end
to_link.flatten!


unless Dir.exist? "#{home}/.oh-my-zsh"
  puts "Installing oh-my-zsh..."
  #`curl -L http://install.ohmyz.sh | sh`
end


puts "Linking files..."
to_link.each do |file|
  home_file = File.join home, file
  repo_file = File.join repo, file

  exists = File.exist?(home_file) || File.symlink?(home_file)

  if exists
    if overwrite_files
      puts "\t\e[0;33mFile #{home_file} exists, but still linking #{repo_file} --> #{home_file}"
      FileUtils.symlink repo_file, home_file, force: true
    else
      puts "\t\e[0;31mFile #{home_file} exists already, remove and rerun to link it"
    end
  else
    puts "\t\e[0;32mLinking #{repo_file} --> #{home_file}"
    FileUtils.symlink repo_file, home_file
  end
end
