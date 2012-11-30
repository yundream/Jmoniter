class MyApp < Sinatra::Application
	before do
		@sysInfo = SysInfo::System.new   
	end
	get "/system/uptime" do
		@items = @sysInfo.sysUptime
		erb :json
	end
	get "/system/hostname" do
		@items = @sysInfo.hostname
		erb :json
	end
	get "/system/cpus" do
		@items = @sysInfo.cpus
		erb :json
	end
	get "/system/meminfo" do
		@items = @sysInfo.meminfo
		erb :json
	end
	get "/system/disk" do
		@items = @sysInfo.disk
		erb :json
	end
end
