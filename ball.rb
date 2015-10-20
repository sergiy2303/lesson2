require 'yaml'
class Ball
  COLORS = { red: 31, green: 32, yellow: 33, blue: 34 }
  ANSWERS = File.open('answers.yml', 'r+') do |file|
    YAML.load(file.read)
  end

  def shake
    key = ANSWERS.keys.sample
    answer = ANSWERS[key].sample
    puts colorize(key, answer)
    answer
  end

  protected

  def colorize(color, string)
    "\e[#{COLORS[color]}m#{string}\e[0m"
  end
end
