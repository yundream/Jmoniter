class MyApp < Sinatra::Application
	before do
		@sysInfo = SysInfo::System.new   
	end
	get "/system/uptime" do
		@body = @sysInfo.sysUptime
		erb :json
	end
end
