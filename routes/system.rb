class MyApp < Sinatra::Application
	before do
		@sysInfo = SysInfo::System.new   
	end
	get "/system/uptime" do
		@body = @sysInfo.sysUptime
		erb :json
	end
	get "/system/hostname" do
		@body = @sysInfo.hostname
		erb :json
	end
end
