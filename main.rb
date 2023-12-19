# main.rb

require 'redis'
require 'colorize'
require_relative 'Human'

begin
  redis = Redis.new(host: 'localhost', port: 6379, db: 0)

  # Preguntar al usuario que desea relizar
  puts "Que desea realizar en este momento?:\n 
            1 = Guardar informacion\n
            2 = Mostrar informacion\n
            3 = Eliminar informacion".colorize(:color => :light_blue)
  information = gets.chomp.to_i

  # Validar la descision tomada por el usuario
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

      puts "Debug: La clave 'person:#{id}' ya existe en la base de datos.".colorize(:color => :green)
      puts "Error: El ID #{id} ya está en uso. Por favor, elige otro ID.".colorize(:color => :red)

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
    puts '=' * 30

    # Verificar si el ID existe para poder mostrarlo
    if redis.hexists("person:#{id}", 'name')

      puts "Debug: La clave 'person:#{id}' existe en la base de datos.\n".colorize(:color => :green)
      result = show(redis, id)
      puts result
    else
      puts "\nLa clave 'person:#{id}' NO existe en la base de datos.\n".colorize(:color => :red)
    end
  when 3
    # Eliminar ID elegido
    puts '=' * 30
    print 'Cual ID que desea borrar: '
    id = gets.chomp
    puts '=' * 30

    # Verificar si el ID existe para borrarlo
    if redis.hexists("person:#{id}", 'name')

      puts "Debug: La clave 'person:#{id}' existe en la base de datos.\n".colorize(:color => :green)
      eliminate(redis, id)

      puts "\nBorrando..."
      sleep 4

      puts "\nID #{id} eliminado"
    else
      puts "\nLa clave 'person:#{id}' NO existe en la base de datos.\n".colorize(:color => :red)
    end
  else
    puts "\nOpcion no valida".upcase
  end

rescue StandardError => e
  puts "Error: #{e.message}".colorize(:color => :red)
end
