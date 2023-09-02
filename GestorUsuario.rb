require 'csv'
require 'sinatra'
require 'json'
ARCHIVO_USUARIOS = 'usuarios.csv'
class GestorUsuario
  attr_accessor :usuarios

    def initialize(data)
        @usuarios = data
    end
    
    def write_data_to_csv
        CSV.open(ARCHIVO_USUARIOS, 'w') do |csv|
          csv << ['nombre', 'correo', 'nombre_usuario', 'contrasena', 'rutasMeGusta', 'rutasFavoritas']
          usuarios.each { |row| csv << row.values }
        end
    end

    def read_data_from_csv
        data = []
        CSV.foreach(ARCHIVO_USUARIOS, headers: true) do |row|
          data << row.to_h
        end
        @usuarios = data
    end
end

gestor = GestorUsuario.new([])

get '/api/users' do
    content_type :json
    gestor.read_data_from_csv
    gestor.usuarios.to_json
end
  
post '/api/users' do
    request_body = JSON.parse(request.body.read)
    gestor.read_data_from_csv
    gestor.usuarios.each_with_index do |usuario, index|
        if usuario['nombre_usuario'] == request_body['nombre_usuario']
          return status 400
        end
      end
    gestor.usuarios << request_body
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