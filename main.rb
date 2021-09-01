class CodeGuesser 

  attr_accessor :guess_color
  attr_writer :guesser_array

  def initialize(guesser_array=[], guess_color='blue')
    @guesser_array = guesser_array
    @guess_color = guess_color
  end

  def compare_input(code_array, guess_color, code_color)
    if code_color == guess_color
      puts "You've guessed this color correctly!"
    elsif code_array.include?(guess_color)
      puts "You've guessed incorrectly, but the computer code does include this color somewhere"
    else
      puts "You've guessed incorrectly, this color isn't anywhere in the computer's code."
    end
  end

  def play_single_turn(code_array)
    code_array.each_with_index do |code_color, index|
      puts "What is your guess for color #{index+1} of the computer code? "
      @guess_color = gets.chomp
      @guesser_array.push(@guess_color)
      compare_input(code_array, @guess_color, code_color)
    end
  end

  def play_twelve_turns(code_array)
    puts "You have twelve turns to guess a computer code, consisting of a random combination of the colors red, blue, green, and yellow."
    12.times do |turn| 
      puts "This is turn # #{turn+1}. "
      play_single_turn(code_array) 
      puts @guesser_array
      check_for_gameover(@guesser_array, code_array)
    end
    puts "Looks like you couldn't get the code after 12 turns, better luck next time!"
  end

  def check_for_gameover(guesser_array, code_array)
    if guesser_array == code_array
      puts "You have correctly guessed the computer's entire code!"
      exit
    else 
      puts "You couldn't guess the code this time around, but let's try again starting at the first color. "
      guesser_array = []
    end
  end
    
end

class CodeSelector

  attr_reader :randomized_code_array

  @@possible_random_colors = ['red', 'blue', 'green', 'yellow']
  def initialize(code_array = [], player_input_guess = '')
    @code_array = code_array
  end

  def randomly_generate_code
    4.times{ @code_array.push(@@possible_random_colors.sample) }
    p @code_array
  end

  def input_generate_code
    4.times do |index|
      puts "Of four total, what color would you like to assign to selection # #{index+1} of the code?"
      @code_array.push(gets.chomp) 
    end
    p @code_array
  end

end

guesser_one = CodeGuesser.new
selector_one = CodeSelector.new
selector_one.input_generate_code
#player_one.play_twelve_turns(computer_code.randomly_generate_code)