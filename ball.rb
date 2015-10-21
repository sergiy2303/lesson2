require 'yaml'
class Ball
  COLORS = { red: 31, green: 32, yellow: 33, blue: 34 }
  ANSWERS = File.open('answers.yml', 'r+') do |file|
    YAML.load(file.read)
  end

  def shake
    answers_hash = COLORS.keys.each_with_object({}) do |val, obj|
      count = obj.count
      obj[val] = ANSWERS[count * 2..count * 2 + 4] if ANSWERS.count > count * 2
    end
    key = answers_hash.keys.sample
    answer = answers_hash[key].sample
    puts colorize(key, answer)
    answer
  end

  protected

  def colorize(color, string)
    "\e[#{COLORS[color]}m#{string}\e[0m"
  end
end
