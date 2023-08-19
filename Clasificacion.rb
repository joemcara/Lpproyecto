require_relative 'ruta'

=begin
crea una lista de rutas basada en la clase Rutas
y las ordena de acuerdo a la valoracion minima de 4.0
para luego mostrarla por pantalla
=end

class Clasificacion
    def initialize(rutas)
      @rutas = rutas
    end
  
    def filtrar_y_guardar_csv(valoracion_minima, archivo_salida)
        rutas_filtradas = @rutas.select { |ruta| ruta.valoracion >= valoracion_minima }
        rutas_filtradas.sort_by! { |ruta| -ruta.valoracion }
    
        CSV.open(archivo_salida, 'w') do |csv|
          csv << ['Nombre', 'Tiempo', 'Dinero', 'Valoración']
          rutas_filtradas.each do |ruta|
            csv << [ruta.nombre, ruta.tiempo, ruta.dinero, ruta.valoracion]
          end
        end
    
        puts "Rutas filtradas y clasificadas guardadas en '#{archivo_salida}'"
      end
    end
  
  ruta1 = Ruta.new("Parque Lineal", 120, 50, 4.5)
  ruta2 = Ruta.new("Bar tiki", 90, 30, 3.8)
  ruta3 = Ruta.new("Malecon del salado", 150, 70, 4.0)
  ruta4 = Ruta.new("Malecon 2000", 180, 100, 4.7)
  ruta5 = Ruta.new("Pizza hut", 180, 101, 4.8)
  ruta6 = Ruta.new("Parque forestal", 180, 102, 4.9)

  
  rutas = [ruta1, ruta2, ruta3, ruta4, ruta5, ruta6]
  
  clasificacion = Clasificacion.new(rutas)
  clasificacion.filtrar_y_guardar_csv(4.0)
  