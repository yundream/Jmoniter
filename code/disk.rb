#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'pp'

diskinfo = Hash.new
IO.foreach('/proc/partitions') do |line|
	if line =~ /[ ]+[0-9]+/ then
		line = line.chomp
		info = line.split(/[ ]+/)
		#puts "#{info[1]} : #{info[2]} #{info[3]} #{info[4]}"
		if ((info[2] == "0")) then 
			puts "Disk #{info[4]} Size #{info[3]}"
			name = info[4]
			info.shift
			diskinfo[name] = info 
		end
	end
end

puts diskinfo.to_json
