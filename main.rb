# main.rb

require 'redis'
require_relative 'Human'

begin
  redis = Redis.new(host: 'localhost', port: 6379, db: 0)

  # Preguntar al usuario que desea relizar
  puts "Que desea realizar en este momento?:\n
            1 = Guardar informacion\n
            2 = Mostrar informacion\n
            3 = Eliminar informacion"
  information = gets.chomp.to_i

  # Validar la descion tomada por el usuario
  case information
  when 1
    # Obtener información para una nueva persona
    puts '=' * 30
    id = obtener_input('Indica el ID').to_i
    puts '=' * 30
    name = obtener_input('Indica el nombre')
    age = obtener_input('Indica la edad').to_i
    puts

    # Verificar si el ID ya está en uso utilizando la conexión redis en Human.rb
    if redis.hexists("person:#{id}", 'name')
      puts "Debug: La clave 'person:#{id}' ya existe en la base de datos."
      puts "Error: El ID #{id} ya está en uso. Por favor, elige otro ID."
    else
      # Guardar información y mostrar mensaje
      keep(redis, id, name, age)
      puts "Guardando..."
      sleep 4
      puts "\nInformación guardada para la persona con ID #{id}\n"

      # Mostrar información para la persona recién guardada
      result = show(redis, id)
      puts result
    end
  when 2
    # Mostrar información para la persona
    puts '=' * 30
    print 'Cual ID deseas ver: '
    id = gets.chomp

    # Linea de separacion
    puts '=' * 30

    result = show(redis, id)
    puts result
  when 3
    puts '=' * 30
    print 'Cual ID que desea borrar: '
    id = gets.chomp
    puts '=' * 30

    eliminate(redis, id)
    puts "\nBorrando..."
    sleep 4
    puts "\nID #{id} eliminado"
  else
    puts 'Opcion no valida'
  end

rescue StandardError => e
  puts "Error: #{e.message}"
end
