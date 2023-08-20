require 'csv'
ARCHIVO_USUARIOS = 'usuarios.csv'
class GestorUsuario
    def initialize
        @usuarios = []
    end

    def crear_usuario(nombre, correo, nombre_usuario, contrasena, rutasMeGusta, rutasFavoritas)
        usuario = Usuario.new(nombre, correo, nombre_usuario, contrasena, rutasMeGusta, rutasFavoritas)
        @usuarios << usuario
        #SOBREESCRIBIR CSV CON TODOS LOS USUARIOS
        CSV.open(archivo, 'w') do |csv|
            @usuarios.each do |usuario|
                datos = usuario.nombre, usuario.correo, usuario.nombre_usuario, usuario.contrasena, usuario.rutasMeGusta, usuario.rutasFavoritas
                csv << datos
            end
        end
    end

end