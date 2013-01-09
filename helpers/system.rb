# encoding: utf-8
require 'json' 

module SysInfo 
	class System
		# 2012/11/21
		def sysUptime
			begin
				lines = File.readlines('/proc/uptime')
			rescue

			end
			uptime = lines[0].split(' ', 2)[0].to_i
			return {"uptime"=>uptime}.to_json
		end
		# 2012/11/22
		def hostname
			begin
				lines = File.readlines('/etc/hostname')
			rescue
			end
			hostname = lines[0].chop
			return {"hostname"=>hostname}.to_json
		end

		# /proc/cpuinfo
		def cpus
			cpunum = 0
			rtv = Hash.new
			File.readlines('/proc/cpuinfo').each do |line|
				if (line =~ /^processor/) then
					cpunum +=1
				end
				if cpunum == 1 then
					if (line =~ /^model name/)
						info=line.split(/[\t ]+:[ ]/,2)
						rtv[:modelname] = info[1].chop
					end
					if (line =~ /^cpu MHz/)
						info=line.split(/[\t ]+:[ ]/,2)
						rtv[:cpumhz] = info[1].chop
					end
					if (line =~ /^cache size/)
						info=line.split(/[\t ]+:[ ]/,2)
						rtv[:cachesize] = info[1].chop
					end
					if (line =~ /^bogomips/)
						info=line.split(/[\t ]+:[ ]/,2)
						rtv[:bogomips] = info[1].chop
					end
				end
			end
			rtv[:cpunum] = cpunum 
			return rtv.to_json
		end

		# /proc/meminfo
		def meminfo
			h = Hash.new
			File.readlines('/proc/meminfo').each do |line|
				record = line.split(/:[ ]+| /)
				h[record[0]] = record[1].to_i
			end
			return h.to_json
		end

		# /proc/partitions & /etc/fstab & statfs & diskstatus 
		def disk
			diskinfo = Array.new
			cmdout = IO.popen('df', 'r')
			Process.wait
			if $? == 0 then
				linenum = 0
				cmdout.each_line do |line|
					if linenum == 0 then
						linenum = 1
						next
					end
					line = line.chomp
					items = line.split(/[ ]+/)
					entry = Hash.new
					entry['filesystem']=items[0]
					entry['size']=items[1]
					entry['used']=items[2]
					entry['available']=items[3]
					entry['mount']=items[4]
					diskinfo.push(entry)
				end
			end
			diskinfo.to_json
		end

		# /proc/cmdline
		def cmdline 
			h = Hash.new
			File.readlines('/proc/cmdline').each do |line|
				h['cmdline'] = line.chomp
			end
			return h.to_json
		end

		# /proc/[pid]
		def processes name=nil
			h = Hash.new
			processes = Array.new
			process_num = 0
			Dir.foreach('/proc') do |entry|

				pid_file = File.join('/proc', entry)
				next if (entry == '.') && (entry == '..')
				next if !File.directory?(pid_file)
				exe_file = File.join(pid_file, 'exe')
				if File.file?(exe_file) then
					if (name != nil) then
						if File.readlink(exe_file) =~ /#{name}/ then
							processes.push(File.readlink(exe_file))
							process_num = process_num +1
						end
					else
						processes.push( File.readlink(exe_file))
						process_num = process_num +1
					end
				end
			end
			h['num'] = process_num
			h['process'] = processes
			return h.to_json
		end
	end
	class Network 
		# /network/interface

		# /network/routes

		# /network/vlan

		# /network/netstat
	end
end
