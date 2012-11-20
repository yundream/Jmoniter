# encoding: utf-8
require 'json' 

module SysInfo 
	class System
		def sysUptime
			begin
				lines = File.readlines('/proc/uptime')
			rescue

			end
			uptime = lines[0].split(' ', 2)[0].to_i
			return {"uptime"=>uptime}.to_json
		end
	end
end
