module Players class Computer < Player 

    def move(board)
        if !board.taken?("5")
            "5"
        else 
            best_move(board)
        end 
    end 

    def best_move(board)
        win(board) || block(board) || corner(board) || other(board)
    end 

end 
end 