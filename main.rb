class Player 

  attr_accessor :player_guess
  attr_writer :player_guess_array

  def initialize(player_guess_array=[], player_guess='blue')
    @player_guess_array = player_guess_array
    @player_guess = player_guess
  end

  def compare_player_input(computer_array, player_input_guess, color)
    if color == player_input_guess
      puts "You've guessed this color correctly!"
    elsif computer_array.include?(player_input_guess)
      puts "You've guessed incorrectly, but the computer code does include this color somewhere"
    else
      puts "You've guessed incorrectly, this color isn't anywhere in the computer's code."
    end
  end

  def play_single_turn(computer_array)
    computer_array.each_with_index do |color, index|
      puts "What is your guess for color #{index+1} of the computer code? "
      @player_guess = gets.chomp
      @player_guess_array.push(@player_guess)
      compare_player_input(computer_array, @player_guess, color)
    end
  end

  def play_twelve_turns(computer_array)
    puts "You have twelve turns to guess a computer code, consisting of a random combination of the colors red, blue, green, and yellow."
    12.times do |turn| 
      puts "This is turn # #{turn+1}. "
      play_single_turn(computer_array) 
      puts @player_guess_array
      check_for_gameover(@player_guess_array, computer_array)
    end
    puts "Looks like you couldn't get the code after 12 turns, better luck next time!"
  end

  def check_for_gameover(player_array, computer_array)
    if player_array == computer_array
      puts "You have correctly guessed the computer's entire code!"
      exit
    else 
      puts "You couldn't guess the code this time around, but let's try again starting at the first color. "
      player_array = []
    end
  end
    
end

class Computer

  attr_reader :computer_code_array

  @@possible_random_colors = ['red', 'blue', 'green', 'yellow']
  def initialize(computer_code_array = [], player_input_guess = '')
    @computer_code_array = computer_code_array
  end

  def randomly_generate_code
    4.times{ @computer_code_array.push(@@possible_random_colors.sample) }
    p @computer_code_array
  end

end

player_one = Player.new
computer_code = Computer.new
player_one.play_twelve_turns(computer_code.randomly_generate_code)