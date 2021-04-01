module Players class Computer < Player 

    def move(board)
        if !board.taken?("5")
            "5"
        else 
           "#{best_move(board) + 1}"
        end 
    end 
    

    def best_move(board)
        win(board) || block(board)  || corner(board) || other(board)
    end 

    def win(board)
        winning_combo = winning_combo?(board, self.token)
        if winning_combo && winning_combo.count{|index| board.position(index+1) == self.token} == 2
            winning_combo.detect{|index| !board.taken?(index+1)}
        end 
    end 

    def winning_combo?(board, token)
        Game::WIN_COMBINATIONS.detect do |combo|
            ((board.cells[combo[0]] == token && board.cells[combo[1]] == token) &&
            !board.taken?(combo[2]+1)) ||
            ((board.cells[combo[1]] == token && board.cells[combo[2]] == token) &&
            !board.taken?(combo[0]+1)) ||
            ((board.cells[combo[0]] == token && board.cells[combo[2]] == token) &&
            !board.taken?(combo[1]+1))
        end 
    end 

    def block(board)
        rival_token = self.token == "X" ? "O" : "X"

        block_combo = winning_combo?(board, rival_token)
        if block_combo && block_combo.count{|index| board.position(index+1) == rival_token} == 2
            block_combo.detect{|index| !board.taken?(index+1)}
        end 
    end    

    def corner(board)
       corner_moves = [0,2,6,8]
       corner_moves.detect{|cell| !board.taken?(cell+1)}
    end 

    def other(board)
        other_moves = [1,3,5,7]
        other_moves.select{|cell| !board.taken?(cell +1)}.sample
    end 

end 
end 

