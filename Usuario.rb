class Usuario
    attr_accessor :nombre, :correo, :rutasMeGusta, :rutasFavoritas, :nombre_usuario, :contrasena

    def initialize(nombre, correo, nombre_usuario, contrasena, rutasMeGusta, rutasFavoritas)
        @nombre = nombre
        @correo = correo
        @rutasMeGusta = rutasMeGusta
        @rutasFavoritas = rutasFavoritas
        @nombre_usuario = nombre_usuario
        @contrasena = contrasena
    end
    
end