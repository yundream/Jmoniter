# encoding: utf-8
require 'sequel'
# DB = Sequel.postgres 'dbname', user:'bduser', password:'dbpass', host:'localhost'
# DB << "SET CLIENT_ENCODING TO 'UTF8';"
DB = Sequel.sqlite
DB.create_table :items do
	primary_key :id
	String :name
	Float :prie
end

require_relative 'user'
