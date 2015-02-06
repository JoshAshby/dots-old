#!/usr/bin/env ruby
require 'fileutils'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: install.rb [options]"

  opts.on '-f', '--force', 'Force overwriting files' do |v|
    options[:force] = v
  end
end.parse!

home = Dir.home
repo = Dir.pwd

dont_link = {
  all: ['README', 'zsh', '.gitignore', '.gitmodules', '.git', '..', '.', __FILE__],
  osx: ['.conkyrc', '.Xmodmap'],
  linux: ['.slate.js']
}

if RUBY_PLATFORM =~ /darwin/
  platform = :osx
else
  platform = :linux
end

except = dont_link[:all] + dont_link[platform]

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
  `curl -L http://install.ohmyz.sh | sh`
end


puts "Linking files..."
to_link.each do |file|
  home_file = File.join home, file
  repo_file = File.join repo, file

  begin
    puts "\t\e[0;32mTrying to link #{repo_file} --> #{home_file}"
    FileUtils.symlink repo_file, home_file
  rescue Errno::EEXIST => e
    if options[:force]
      puts "\t\e[0;33mFile #{home_file} exists, linking anyways #{repo_file} --> #{home_file}"
      FileUtils.symlink repo_file, home_file, force: options[:force]
    else
      puts "\t\e[0;31mFile #{home_file} exists already, remove and rerun to link it"
    end
  end
end
