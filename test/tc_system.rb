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
		json['uptime'].should be > 0 
	end
	it ": hostname" do
		get '/system/hostname'
		body = last_response.body	
		json = JSON.parse(body)
		json['hostname'].should match(/[a-zA-Z0-9\-_\.]+/) 
	end
end
