require 'sinatra'
require 'webrick'

#Requerimiento de gestor de rutas para CRUD de usuarios
require_relative 'GestorUsuario'

set :port, 4567
run Sinatra::Application

