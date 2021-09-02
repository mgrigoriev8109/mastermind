class CodeGuesser 

  @@possible_random_colors = ['red', 'blue', 'green', 'yellow']

  attr_accessor :guess_color, :player_plays
  attr_writer :guesser_array

  def initialize(guesser_array = [], guess_color = 'blue', player_plays = true)
    @guesser_array = guesser_array
    @guess_color = guess_color
    @player_plays = player_plays
  end

  def computer_or_human_play
    if @player_plays == true
      @guess_color = gets.chomp
    else
      @guess_color = @@possible_random_colors.sample
    end
  end

  def compare_input(code_array, guess_color, code_color)
    if code_color == guess_color
      puts "This color was guessed correctly!"
    elsif code_array.include?(guess_color)
      puts "This color is incorrect, but the code does include this color somewhere"
    else
      puts "This color is incorrect, this color isn't anywhere in the code."
    end
  end

  def play_single_turn(code_array)
    code_array.each_with_index do |code_color, index|
      puts "What is the guess for color #{index + 1} of the code? "
      computer_or_human_play
      @guesser_array.push(@guess_color)
      compare_input(code_array, @guess_color, code_color)
    end
  end

  def play_twelve_turns(code_array)
    puts "There are twelve turns to guess a code, consisting of a random combination of the colors red, blue, green, and yellow."
    12.times do |turn| 
      puts "This is turn # #{turn + 1}. "
      play_single_turn(code_array) 
      puts @guesser_array
      check_for_gameover(@guesser_array, code_array)
    end
    puts "Looks like the code couldn't be guessed after 12 turns, better luck next time!"
  end

  def check_for_gameover(guesser_array, code_array)
    if guesser_array == code_array
      puts "The entire code has been guessed correctly!"
      exit
    else 
      puts "The code couldn't be guessed, but let's try again starting at the first color. "
      @guesser_array = []
    end
  end
    
end

class CodeSelector

  attr_reader :randomized_code_array

  @@possible_random_colors = ['red', 'blue', 'green', 'yellow']
  def initialize(code_array = [])
    @code_array = code_array
  end

  def randomly_generate_code
    4.times{ @code_array.push(@@possible_random_colors.sample) }
    p @code_array
    @code_array
  end

  def input_generate_code
    4.times do |index|
      puts "Of four total, what color would you like to assign to selection # #{index + 1} of the code?"
      @code_array.push(gets.chomp) 
    end
    p @code_array
  end

end

guesser_one = CodeGuesser.new
selector_one = CodeSelector.new

guesser_one.play_twelve_turns(selector_one.randomly_generate_code)