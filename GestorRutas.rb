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
          csv << ["nombre","tiempo","dinero","valoracion", "likes", "no_recomendado"]
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
# Habilitar CORS para todas las rutas

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
  nombreRuta = params['nombre']
  request_body = JSON.parse(request.body.read)
  gestor.read_data_from_csv
  gestor.rutas.each_with_index do |ruta, index|
    if ruta['nombre'] == nombreRuta
      gestor.rutas[index] = request_body
    end
  end
  gestor.write_data_to_csv()
  status 200
  {"UPDATED" => nombreRuta}.to_json
end

delete '/api/rutas/:nombre' do
    nombreRuta = params['nombre']
    gestor.read_data_from_csv
    gestor.rutas.each_with_index do |ruta, index|
      if ruta['nombre'] == nombreRuta
        gestor.rutas.delete_at(index)
      end
    end
    gestor.write_data_to_csv()
    status 200
    {"DELETED" => nombreRuta}.to_json
end