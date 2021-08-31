
#To start this game should play 1 round of player guessing a computer's random code
#Computer randomly selects secret colors into computer_code_array[]
#Player guesses color for first index and it goes into player_guess_array[]
#Player receives feedback about how good a guess was
    # - If guess was correct exactly, or just correct color but wrong space
        # - array[index] == guess or array.include?(color)
    # - If entire array guessed correctly computer_code_array[] == player_guess_array[]
        # - Player wins
#After a round player_guess_array[] resets and game goes back to line 4