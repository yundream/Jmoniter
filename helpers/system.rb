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
		def cpu
		end

		# /proc/meminfo
		def memory
		end

		# /proc/partitions & /etc/fstab & statfs & diskstatus 
		def disk
		end

		# /proc/cmdline
		def bootparameter
		end
	end
end
