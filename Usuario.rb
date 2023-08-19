class Usuario
    attr_accessor :nombre, :correo, :rutas, :nombre_usuario, :contrasena

    def initialize(nombre, correo, nombre_usuario, contrasena, rutas)
        @nombre = nombre
        @correo = correo
        @rutas = rutas
        @nombre_usuario = nombre_usuario
        @contrasena = contrasena
    end
    
end