WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom Row
  [0,4,8],  # \
  [2,4,6],  # /
  [0,3,6],  # | left
  [1,4,7],  # | center
  [2,5,8],  # | right
]

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts '-----------'
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts '-----------'
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(board, index, player)
    board[index] = player
  end

  def position_taken?(board, index)
    !(board[index].nil? || board[index] == " ")
  end

  def valid_move?(board, index)
    if index.between?(0,8)
      if !position_taken?(board, index)
        true
      end
    end
  end

  def turn_count(board)
    board.count { |token| token == 'X' || token == 'O' }
  end
  
  def current_player(board)
    turn_count(board).even? ? 'X' : 'O'
  end

  def turn(board)
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end

  def won?(board)
    WIN_COMBINATIONS.detect do |combos| #returns falsey empty board and draw
      board[combos[0]] == board[combos[1]] && 
      board[combos[1]] == board[combos[2]] && 
      position_taken?(board, combos[0])     #returns an array for matching indexes of winning combos
    end
  end

  def full?(board)
    board.all?{|token| token  == "X" || token == "O"} #returns true for full board by confirming all spots are full by either token
  end

  def draw?(board)
    full?(board) && !won?(board) #returns draw if either board full and game not won
  end

  def over?(board)
    won?(board) || draw?(board) #returns true for either won or draw board
  end

  def winner(board)
    if winning_combo = won?(board)
      board[winning_combo.first] #returns who won or nil first
    end  
end

def play(board)
    turn(board) until over?(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end