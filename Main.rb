require 'sinatra'
require_relative 'crud_operations'

set :port, 4567
run Sinatra::Application

