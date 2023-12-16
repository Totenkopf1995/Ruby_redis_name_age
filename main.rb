# main.rb

require 'redis'
require_relative 'Human'

def obtener_input(prompt)
  print "#{prompt}: "
  gets.chomp
end

begin
  redis = Redis.new(host: 'localhost', port: 6379, db: 0)

  # Obtener información para una nueva persona
  id = obtener_input('Indica el ID').to_i
  name = obtener_input('Indica el nombre')
  age = obtener_input('Indica la edad').to_i

  # Verificar si el ID ya está en uso utilizando la conexión redis en Human.rb
  if redis.hexists("person:#{id}", 'name')
    puts "Debug: La clave 'person:#{id}' ya existe en la base de datos."
    puts "Error: El ID #{id} ya está en uso. Por favor, elige otro ID."
  else
    # Guardar información y mostrar mensaje
    keep(redis, id, name, age)
    puts "\nGuardando..."
    sleep 4
    puts "\nInformación guardada para la persona con ID #{id}\n"

    # Mostrar información para la persona recién guardada
    result = show(redis, id)
    puts result
  end

rescue StandardError => e
  puts "Error: #{e.message}"
end
