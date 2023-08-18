class GestorRutas
  
    def initialize
      @rutas = []
    end
  
    def crear_ruta(nombre, tiempo, dinero)
      ruta = Ruta.new(nombre, tiempo, dinero)
      @rutas << ruta
    end
  
    def listar_rutas
      @rutas.each_with_index do |ruta, index|
        puts "Ruta #{index + 1}:"
        puts "Nombre: #{ruta.nombre}"
        puts "Tiempo: #{ruta.tiempo}"
        puts "Dinero necesario: #{ruta.dinero}"
        puts "--------------------------"
      end
    end
  
    def actualizar_ruta(index, nombre, tiempo, dinero)
      if index >= 0 && index < @rutas.length
        @rutas[index].nombre = nombre
        @rutas[index].tiempo = tiempo
        @rutas[index].dinero = dinero
      else
        puts "Índice de ruta no válido."
      end
    end
  
    def eliminar_ruta(index)
      if index >= 0 && index < @rutas.length
        @rutas.delete_at(index)
      else
        puts "Índice de ruta no válido."
      end
    end
  end
  