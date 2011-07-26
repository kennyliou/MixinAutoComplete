#!/usr/bin/env ruby

require 'plist'


bondule_location = ARGV[0]
project_path = ARGV[1]
file_path = ARGV[2]
file_name = File.basename("#{file_path}")

puts "check file #{file_name} ..."
puts "check file path #{file_path} ..."
puts "check project path #{project_path} ..."
puts "check bondule location #{bondule_location} ..."
if file_name == "_lib.scss"
  begin
    puts "generating mixins.plist ..."
    hash = []
    File.open("#{project_path}/assets/stylesheets/_lib.scss") do |f|
     f.grep( /\@mixin\s\w*\([\$\w*\:?\#?\w*]*\)\s\{/ ) do |line|
        puts line
        line["@mixin "] = ""
        line[" {"] = ""
        line["()"] = ""
        line = line.chop
        hash += [:insert => "(${1:});", :display => "@include #{line}"]
      end
      hash.save_plist("#{bondule_location}/mixins.plist")
    end
    puts "plist is generated"
  rescue

  end
end