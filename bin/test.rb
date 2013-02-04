#!/usr/bin/env ruby

require "./lib/alpm.rb"

al = ALPM::init "/", "/var/lib/pacman"

puts "init'd"
