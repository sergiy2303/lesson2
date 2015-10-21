require_relative 'pet'

puts "Give a name for your sea cucumber"
pet = Pet.new(gets)
run = true
while run
  break unless pet.alive?
  puts "\n \n"
  puts 'Insert command'
  command = gets.downcase.strip.gsub(' ','_').to_sym
  if pet.methods.include?(command)
    puts 'Insert parametr for your command'
    pet.send(command)
  elsif command == :exit
    break
  else
    puts 'Wrong command'
  end
end