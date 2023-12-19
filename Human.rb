# Human.rb
require 'colorize'

# Funcion para pedir informacion al usuario
def obtener_input(prompt)
  print "#{prompt}: "
  gets.chomp
end

# Validar si el ID es un numero entero
def validation(id)
  begin
    user_id = Integer(id)
    puts "El ID ingresado es un número entero: #{user_id}".colorize(:color => :green)
    puts

  rescue ArgumentError
    puts "Error: La entrada no es un número entero.".colorize(:color => :red)
    exit
  end
end

# Funcion para guadrar la informacion en redis
def keep(redis, id, name, age)
  redis.hset("person:#{id}", 'name', name)
  redis.hset("person:#{id}", 'age', age.to_s)
end

# Funcion para mostrar la informacion de redis
def show(redis, id)
  name = redis.hget("person:#{id}", 'name')
  age = redis.hget("person:#{id}", 'age')

  result = "\nID: #{id}\n"
  result += "Nombre: #{name}\n" unless name.nil?
  result += "Edad: #{age}\n" unless age.nil?

  result
end

# Funcion para eliminar ingformacion de redis
def eliminate(redis, id)
  redis.del("person:#{id}")
end
