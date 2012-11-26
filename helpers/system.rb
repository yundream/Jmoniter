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
		end

		# /proc/cmdline
		def bootparameter
		end

		# /proc/[pid]
	end
	class Network 
		# /network/interface

		# /network/routes

		# /network/vlan

		# /network/netstat
	end
end
