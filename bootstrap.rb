#!/usr/bin/env ruby
# Modified from https://github.com/thcipriani/dotfiles/blob/35a9f633c2b5e38771fa65397323d579e29ba817/bootstrap.rb

home = File.expand_path '~'
dotfiles = File.expand_path '~/repos/dots'

hard_links = %w||
dirs_to_link = %w| bin .ssh .config/fish .config/nvim .vim |
skip_links = [ %w| README bootstrap.rb |, dirs_to_link, hard_links ].flatten

Dir['*'].each do |file|
  next if file =~ /#{ skip_links.join '|' }/

  target = File.join home, ".#{ file }"
  `ln -sf "#{ File.join dotfiles, file }" "#{ target }"`
end

dirs_to_link.each do |dir|
  `ln -sf "#{ File.join dotfiles, dir }" "#{ File.join home, dir }"`
end

hard_links.each do |file|
  target = File.join home, ".#{file}"
  `ln "#{ File.join dotfiles, file }" "#{ target }"`
end
