class Pet
  HELP = File.open('help.txt', 'r+', &:read)
  def initialize(name = 'Cucy')
    @name = name
    @alive = true
    @hungry = 100
    @health = 100
    @length = 40.0
    @mood = 100
    @fatigue = 0
    @water = 100
    @clean = 100
    @salt_level = 100
    @old = 0

    puts "Hello! your new best friend was born. His name is #{@name}, he is a Sea cucumber"
  end

  def add_mineral_salt_to_aquarium
    add_empty_line
    puts 'Looks like water needs some sea sald'
    @salt_level = 100
    puts 'Woh it salted'
  end

  def add_water_to_aquarium
    add_empty_line
    puts 'Lets add some water into your aquarium'
    @salt_level = @water
    @water = 100
    puts 'It is full. Do you need more sea sald?'
  end

  def clean_aquarium
    add_empty_line
    puts 'Lets make it\'s clean!'
    @clean = 100
    time_spend 1
    puts 'Wow like a new.'
  end

  def cook_cucumber_salad
    add_empty_line
    puts 'I am hungry. I want a cucumber salad.'
    change_mood(-30)
    time_spend 1
    puts "Yamy!!! Why do you cry #{@name}?"
  end

  def feed(food = nil)
    add_empty_line
    if food.nil?
      puts "Insert type of food, #{@name} like"
      food = input_text
    end
    if food.downcase == 'plankton'
      puts 'I am going to give you a lot of plankton'
      @hungry = @hungry + 50 > 100 ? 100 : @hungry + 50
      'Yamy!!!'
    else
      puts "I don't have special food. Try #{food}"
      change_mood(-10)
      'Why you not eating?'
    end
    time_spend 1
  end

  def help
    add_empty_line
    puts HELP
  end

  def make_massage
    add_empty_line
    puts 'Do you want some masage? I know you like it.'
    change_mood
    @health += 5
    time_spend 1
    puts 'Yea, I have magic hangs'
  end

  def on_music(style = nil)
    add_empty_line
    puts 'Do you want some music?'
    if style.nil?
      puts 'Enter ganre'
      style = input_text
    end
    if style == 'classic'
      puts 'Your favorite, Lindsay Stirling'
      change_mood
    else
      puts "I think you not protest #{style}"
      change_mood(-10)
    end
    time_spend 1
    puts 'Enough music for now'
  end

  def play
    add_empty_line
    puts "Lets play with my friend #{@name}"
    game
    change_mood 10
    time_spend 3
    puts 'Ooh, it was hice. 3 hours spend already...'
  end

  def status
    add_empty_line
    puts "Name: #{@name}"
    puts "Alive: #{@alive}"
    puts "Hungry: #{@hungry}"
    puts "Health #{@health}HP"
    puts "Length: #{@length}sm"
    puts "Mood: #{@mood}"
    puts "Faigue: #{@fatigue}"
    puts "Water level: #{@water}"
    puts "Clean level: #{@clean}"
    puts "Salt level: #{@salt_level}"
    puts "Hours old: #{@old}"
  end

  def sleep(hours = nil)
    add_empty_line
    if hours.nil?
      puts "How many hours do you wont to sleep"
      hours = input_text.to_i
    end
    puts "Goodnight #{@name}"
    @fatigue = 0
    time_spend(hours)
    puts 'Looks like morning already'
  end

  def skip_day
    add_empty_line
    puts 'I need do to some business. I will back tomorow'
    random_thing
    time_spend 24
    puts 'Hi, how are you? Did I feed you yesterday?'
  end

  def skip_hour
    add_empty_line
    puts 'Hour is skiped'
    time_spend 1
  end

  def walk(aquarium = nil)
    add_empty_line
    if aquarium.nil?
      puts 'Do you want to take aquarium?'
      aquarium = input_text == 'yes' ? true : false
    end
    if aquarium
      puts 'I know you a sea animal. You need a water. Lets take aquarium'
      change_mood
      puts 'It was fantastic!'
    else
      puts 'I think short walk without aquarium it not so bad idea'
      change_mood(10)
      @health -= 10
      puts 'It was not so good. Waht i did wrong?'
    end
    time_spend 2
  end

  def alive?
    puts "#{@name} is dead. It is your false!" unless @alive
    @alive
  end

  private

  def change_mood(value = 10)
    @mood += value
  end

  def change_params(hours)
    @hungry -= hours * 2
    @health -= hours * 2 if @hungry < 0 || @fatigue > 100
    @length += hours * 0.01 if alive? && @health > 50
    @clean -= hours * 100 / @water
    @water -= hours
    @alive = false if @health <= 0
    hungry_warnings
    health_warnings
    sleep_warnings
  end

  def game
    puts "Choose direction where #{@name} will creep left or right"
    direction = %w(left rigth)
    5.times do
      choose = gets.downcase.strip
      if choose == direction.sample
        puts 'Correct!! Yha!'
        break
      else
        puts 'Not correct'
      end
    end
    puts 'Good game!'
  end

  def hungry_warnings
    return if @hungry > 50
    puts "Looks like #{@name} is hungry"
    return if @hungry > 30
    puts "Looks like #{@name} is very hungry"
    return if @hungry > 10
    puts "#{@name} needs food now."
  end

  def health_warnings
    return if @health > 60
    puts "#{@name}: I feeling not so good"
    return if @health > 50
    puts "#{@name}: I am ill master, please help me!"
    return if @health > 30
    puts "#{@name}: I am dying.."
  end

  def time_spend(hours)
    return unless alive?
    @old += hours
    change_params(hours)
  end

  def sleep_warnings
    return if @fatigue < 70
    puts "Looks like #{@name} wants sleep and rest"
    return if @fatigue < 90
    puts "#{@name} is really need a rest"
    return if @fatigue < 100
    puts "#{@name}: Let me alone, I want to sleep"
  end

  def random_thing
    num = rand(4)
    case num
    when 0
      puts "Fly dropped into aquarium. #{@name} succesfully eat it."
      @hungry += 10
    when 1
      puts "My niece came, she will play with #{@name}"
      change_mood(10)
    when 2
      return unless @mood < 10
      puts "#{@name} attempted suicide. Cucumbers are very vulnerable."
    when 3
      return unless @mood < 30
      puts "#{@name} tried to escape. But he is only cucumber. He can't escape"
    end
  end

  def input_text
    gets.strip.downcase
  end

  def add_empty_line
    puts "\n"
  end
end
