class CodeGuesser 
  attr_accessor :guess_color, :known_colors_array, :next_computer_guess, :possible_random_colors
  attr_writer :guesser_array
  attr_reader :player_plays

  def initialize(possible_random_colors = ['red', 'blue', 'green', 'yellow'], player_plays = false, guesser_array = [], guess_color = 'blue', known_colors_array = [], next_computer_guess = '', remaining_colors_array = [])
    @guesser_array = guesser_array
    @guess_color = guess_color
    @player_plays = player_plays
    @known_colors_array = known_colors_array
    @next_computer_guess = next_computer_guess
    @remaining_colors_array = remaining_colors_array
    @possible_random_colors = possible_random_colors
  end

  def play_twelve_turns(code_array)
    puts "There are twelve turns to guess a code, consisting of a random combination of the colors red, blue, green, and yellow."
    @remaining_colors_array = Array.new(code_array)
    12.times do |turn| 
      puts "This is turn # #{turn + 1}. "
      play_single_turn(code_array) 
      check_for_gameover(@guesser_array, code_array)
    end
    puts "Looks like the code couldn't be guessed after 12 turns, better luck next time!"
  end

  private 

  def computer_or_human_play(index)
    if @player_plays == true
      @guess_color = gets.chomp
    elsif @known_colors_array[index]
      @guess_color = @known_colors_array[index]
    elsif @next_computer_guess != ''
      @guess_color = @next_computer_guess
    else
      @guess_color = @possible_random_colors.sample
      puts "The computer has guessed #{@guess_color}"
    end
  end

  def compare_input(code_array, guess_color, code_color, index)
    if code_color == guess_color
      puts "#{guess_color} was guessed correctly!"
      @known_colors_array.slice!(index)
      @known_colors_array.insert(index, guess_color)
      @next_computer_guess = ''
      @remaining_colors_array.delete_at(@remaining_colors_array.index(guess_color))
    elsif @remaining_colors_array.include?(guess_color)
      puts "#{guess_color} is incorrect, but the code does include #{guess_color} somewhere"
      @next_computer_guess = guess_color
    else
      puts "#{guess_color} is incorrect, #{guess_color} isn't anywhere in the code."
      @possible_random_colors.delete(guess_color)
    end
  end

  def play_single_turn(code_array)
    code_array.each_with_index do |code_color, index|
      puts "What is the guess for color #{index + 1} of the code? "
      computer_or_human_play(index)
      @guesser_array.push(@guess_color)
      if @known_colors_array[index]
        puts "The current known code is #{@known_colors_array}, and this color is already known to be #{@known_colors_array[index]}"
      else
        compare_input(code_array, @guess_color, code_color, index)
      end
    end
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

puts "Would you like to be the guesser of this code? Say Yes if that's the case, otherwise type No and you'll create a code for the computer."
player_input = gets.chomp
if player_input == "Yes"
  guesser_human = CodeGuesser.new(true)
  selector_computer = CodeSelector.new
  guesser_human.play_twelve_turns(selector_computer.randomly_generate_code)
else
  guesser_computer = CodeGuesser.new
  selector_human = CodeSelector.new
  guesser_computer.play_twelve_turns(selector_human.input_generate_code)
end
