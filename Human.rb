# Human.rb

# Funcion para pedir informacion al usuario
def obtener_input(prompt)
  print "#{prompt}: "
  gets.chomp
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

# Funcion para verificar la existencia del ID
def id_exists?(redis, id)
  puts "Debug: Verificando existencia de la clave 'person:#{id}' en la base de datos."
  redis.hexists("person:#{id}", 'name')
end
