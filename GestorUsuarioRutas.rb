require 'csv'
require 'sinatra'
require 'json'
ARCHIVO_USUARIOS_RUTA = 'rutas-usuarios.csv'
class GestorUsuarioRutas
  attr_accessor :usuarioRutas

    def initialize(data)
        @usuarioRutas = data
    end
    def write_data_to_csv
        CSV.open(ARCHIVO_USUARIOS_RUTA, 'w') do |csv|
          csv << ['usuario', 'ruta']
          usuarioRutas.each { |row| csv << row.values }
        end
    end
    def read_data_from_csv
        data = []
        CSV.foreach(ARCHIVO_USUARIOS_RUTA, headers: true) do |row|
          data << row.to_h
        end
        @usuarioRutas = data
    end
end

gestor = GestorUsuarioRutas.new([])

get '/api/users_routes' do
    content_type :json
    gestor.read_data_from_csv
    gestor.usuarioRutas.to_json
end
  
post '/api/users_routes' do
    request_body = JSON.parse(request.body.read)
    gestor.read_data_from_csv
    gestor.usuarioRutas.each_with_index do |userRoutePair, index|
        if userRoutePair['usuario'] == request_body['usuario'] && userRoutePair['ruta'] == request_body['ruta']
          return status 400
        end
      end
    gestor.usuarioRutas << request_body
    gestor.write_data_to_csv()
    status 201
    request_body.to_json
end

delete '/api/users_routes/:usuario/:ruta' do
    nombreRuta = params['ruta']
    nombreUsuario = params['usuario']
    gestor.read_data_from_csv()
    index = gestor.usuarioRutas.find_index { |ruta| ruta['ruta'] == nombreRuta && ruta['usuario'] == nombreUsuario}
    gestor.usuarioRutas.delete_at(index.to_i)
    gestor.write_data_to_csv()
    status 204
end


