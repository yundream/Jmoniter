#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'pp'

PROC_DIR = '/proc'
process_num = 0
h = Hash.new
Dir.foreach(PROC_DIR) do | entry |
	next if (entry == '.') && (entry == '..')

	pid_file = File.join(PROC_DIR, entry)
	next if !File.directory?(pid_file)

	exe_file = File.join(pid_file, 'exe')
	if File.file?(exe_file) then
		puts File.readlink(exe_file)
	end

	process_num = process_num +1
end

puts "ProcessNum #{process_num}"
