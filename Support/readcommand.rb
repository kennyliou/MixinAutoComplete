#!/usr/bin/env ruby

require 'plist'

project_path = ARGV[1]
bondule_location = ARGV[0]



begin
  hash = []
  #lib_file = File.open("#{project_path}/asset/stylesheet/lib.scss")
  
  File.open("#{project_path}/assets/stylesheets/lib.scss") do |f|
   f.grep( /\@mixin\s\w*\(\w*\)\s\{/ ) do |line|
      line["@mixin "] = ""
      line[" {"] = ""
      line["()"] = ""
      line = line.chop
      hash += [:insert => "(${1:});", :display => "@include #{line}"]
    end
    hash.save_plist("#{bondule_location}/test.plist")
  end
  puts "plist is generated"
rescue

end