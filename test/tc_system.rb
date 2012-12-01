Dir.chdir('../')
require 'app'
require 'rack/test'
require 'json'

describe 'system information' do
	include Rack::Test::Methods
	def app
		MyApp
	end
	it ": system uptime" do
		get '/system/uptime'
		body = last_response.body
		json = JSON.parse(body)	
		json['items']['uptime'].should be > 0 
	end
	it ": hostname" do
		get '/system/hostname'
		body = last_response.body	
		json = JSON.parse(body)
		json['items']['hostname'].should match(/[a-zA-Z0-9\-_\.]+/) 
	end
	it ": cpu infos" do
		get '/system/cpus'
		body = last_response.body	
		json = JSON.parse(body)
		json['items']['cpunum'].should be > 0 
	end
	it ": mem info" do
		get '/system/meminfo'
		body = last_response.body
		json = JSON.parse(body)
		json['items']['MemTotal'].should be > 0 
	end
	it ": disk info" do
		get '/system/disk'
		body = last_response.body
		json = JSON.parse(body)
	end
	it ": cmdline" do
		get '/system/cmdline'
		body = last_response.body
		json = JSON.parse(body)
		json['items']['cmdline'].should match(/^BOOT_IMAGE=/) 
	end
	it ": process list" do
		get '/system/processes'
		body = last_response.body
		json = JSON.parse(body)
		json['items']['num'].should be > 0 
	end
end
