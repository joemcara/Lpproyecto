class Ruta
    attr_accessor :nombre, :tiempo, :dinero, :valoracion
  
    def initialize(nombre, tiempo, dinero, valoracion)
      @nombre = nombre
      @tiempo = tiempo
      @dinero = dinero
      @valoracion = valoracion
    end
  end
  