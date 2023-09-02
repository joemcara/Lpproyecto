require 'sinatra'
require 'webrick'
require 'sinatra/cross_origin'
configure do
    enable :cross_origin
  end
  
  before do
    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Origin'] = '*' # O reemplaza '*' con el dominio específico que deseas permitir
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'
  end
  
#Requerimiento de gestor de endpoints para CRUD de usuarios
require_relative 'GestorUsuario'

#Requerimiento de gestor de endpoints para CRUD de rutas
require_relative 'GestorRutas'

#Requerimiento de gestor de endpoints para CRUD de usuario-rutas
require_relative 'GestorUsuarioRutas'

