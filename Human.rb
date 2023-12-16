# Human.rb

def keep(redis, id, name, age)
  redis.hset("person:#{id}", 'name', name)
  redis.hset("person:#{id}", 'age', age.to_s)
end

def show(redis, id)
  name = redis.hget("person:#{id}", 'name')
  age = redis.hget("person:#{id}", 'age')

  result = "ID: #{id}\n"
  result += "Nombre: #{name}\n" unless name.nil?
  result += "Edad: #{age}\n" unless age.nil?

  result
end

def eliminate(redis, id)
  redis.del("person:#{id}")

end

def id_exists?(redis, id)
  puts "Debug: Verificando existencia de la clave 'person:#{id}' en la base de datos."
  redis.hexists("person:#{id}", 'name')
end
