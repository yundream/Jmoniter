# encoding: utf-8
class MyApp < Sinatra::Application
	get "/cpu/infos" do
		lines = IO.readline('/proc/cpuinfo', 'r')
		lines.each do | line |
			puts line
		end
		erb :json
	end
end
