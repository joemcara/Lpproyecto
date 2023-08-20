require 'csv'
require 'sinatra'
require 'json'
ARCHIVO = 'rutas.csv'
class GestorRutas
  attr_accessor :rutas

    def initialize(data)
      @rutas = data
    end
  
    def write_data_to_csv()      
      CSV.open(ARCHIVO, 'w') do |csv|
          csv << ["nombre","tiempo","dinero","valoracion"]
          rutas.each {|row| csv << row.values}
        end
    end
  
    def read_data_from_csv
      data = []
      CSV.foreach(ARCHIVO, headers: true) do |row|
        data << row.to_h
      end
      @rutas = data
      end
end

gestor = GestorRutas.new([])
  
  get '/api/rutas' do
    content_type :json
    gestor.read_data_from_csv
    gestor.rutas.to_json
end
  
post '/api/rutas' do
    request_body = JSON.parse(request.body.read)
    gestor.read_data_from_csv
    gestor.rutas << request_body
    gestor.write_data_to_csv()
    status 201
    request_body.to_json
end

put '/api/rutas/:nombre' do
    id = params['id'].to_i
    request_body = JSON.parse(request.body.read)
    data = read_data_from_csv
    data[id] = request_body
    write_data_to_csv(data)
    status 204
end

delete '/api/rutas/:nombre' do
    id = params['user'].to_i
    data = read_data_from_csv
    data.delete_at(id)
    write_data_to_csv(data)
    status 204
end