
#To start this game should play 1 round of player guessing a computer's random code
#Computer randomly selects secret colors into computer_code_array[]
#Player guesses color for first index and it goes into player_guess_array[]
#Player receives feedback about how good a guess was
    # - If guess was correct exactly, or just correct color but wrong space
        # - array[index] == guess or array.include?(color)
    # - If entire array guessed correctly computer_code_array[] == player_guess_array[]
        # - Player wins
#After a round player_guess_array[] resets and game goes back to line 4

class Player 

  def initialize(player_guess_array=[], player_guess='blue')
    @player_guess_array = player_guess_array
    @player_guess = player_guess
  end

  def get_player_guess
    print "What is your guess for the first index of the computer code?"
    @player_guess = gets.chomp
  end

end

class Computer

  attr_accessor :computer_code_array

  @@possible_random_colors = ['red', 'blue', 'green', 'yellow']
  def initialize(computer_code_array=[])
    @computer_code_array = computer_code_array
  end

  def randomly_generate_code
    4.times{ @computer_code_array.push(@@possible_random_colors.sample) }
    p @computer_code_array
  end

  def compare_player_input(player_input_guess)
    p player_input_guess
    if @computer_code_array[0] == player_input_guess
      p "You've guessed this index correctly!"
    elsif @computer_code_array.include?(player_input_guess)
      p "You've guessed incorrectly, but the computer code does include this color somewhere"
    else
      p "You've guessed incorrectly, this color isn't anywhere in the computer's code."
    end
  end
end

first_player_turn = Player.new
computer_code = Computer.new
computer_code.randomly_generate_code
computer_code.compare_player_input(first_player_turn.get_player_guess)