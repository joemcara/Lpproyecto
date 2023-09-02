require 'csv'
require 'sinatra'
require 'json'
ARCHIVO_USUARIOS = 'rutas-usuarios.csv'
class GestorUsuarioRutas
  attr_accessor :usuarioRutas

    def initialize(data)
        @usuarioRutas = data
    end
    def write_data_to_csv
        CSV.open(ARCHIVO_USUARIOS, 'w') do |csv|
          csv << ['usuario', 'ruta']
          usuarioRutas.each { |row| csv << row.values }
        end
    end
    def read_data_from_csv
        data = []
        CSV.foreach(ARCHIVO_USUARIOS, headers: true) do |row|
          data << row.to_h
        end
        @usuarioRutas = data
    end
end

gestor = GestorUsuarioRutas.new([])

get '/api/users-routes' do
    content_type :json
    gestor.read_data_from_csv
    gestor.usuarioRutas.to_json
end
  
post '/api/users-routes' do
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

put '/api/users/:id' do
    id = params['id'].to_i
    request_body = JSON.parse(request.body.read)
    data = read_data_from_csv
    data[id] = request_body
    write_data_to_csv(data)
    status 204
end

delete '/api/users/:ruta' do
    id = params['user'].to_i
    data = read_data_from_csv
    data.delete_at(id)
    write_data_to_csv(data)
    status 204
end