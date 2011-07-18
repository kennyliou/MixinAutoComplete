#!/usr/bin/env ruby

require 'plist'


bondule_location = ARGV[0]
project_path = ARGV[1]
file_path = ARGV[2]
file_name = File.basename("#{file_path}")

if file_name == "lib.scss"
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
end