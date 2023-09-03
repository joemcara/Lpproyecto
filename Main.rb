require 'sinatra'
require 'webrick'
require 'sinatra/cross_origin'
configure do
    enable :cross_origin
  end
  
  before do
    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'
  end
  
  options '*' do
    response.headers['Allow'] = 'HEAD,GET,PUT,POST,DELETE,OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
    204
  end


#Requerimiento de gestor de endpoints para CRUD de usuarios
require_relative 'GestorUsuario'

#Requerimiento de gestor de endpoints para CRUD de rutas
require_relative 'GestorRutas'

#Requerimiento de gestor de endpoints para CRUD de usuario-rutas
require_relative 'GestorUsuarioRutas'

