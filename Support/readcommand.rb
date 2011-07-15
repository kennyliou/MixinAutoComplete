#!/usr/bin/env ruby

require 'plist'

project_path = ARGV[1]
support_path = ARGV[0]

begin
  hash = []
  
  File.open("#{project_path}/assets/stylesheets/lib.scss") do |f|
   f.grep( /\@mixin\s\w*\(\w*\)\s\{/ ) do |line|
      line["@mixin "] = ""
      line[" {"] = ""
      line["()"] = ""
      line = line.chop
      hash += [:insert => "(${1:});", :display => "@include #{line}"]
    end
    File.open("#{support_path}/mixins.plist", "w")
    hash.save_plist("#{support_path}/mixins.plist")
  end
  puts "plist is generated at #{support_path}/mixins.plist"
rescue

end