//
//  MVCViewController.swift
//  ThreeInARow
//
//  Created by Jesper Söderling on 2021-12-03.
//

import UIKit

class Game {
    
   
    
    private var board = ["_", "_", "_", "_", "_", "_", "_", "_", "_"]
    
    var CROSS = "X"
    var CIRCLE = "O"
    var EMPTY = "_"
    

    
    func addToBoard(position: Int, marker: String) -> Bool  {
        
        if board[position] == EMPTY {
            board[position] = marker
            return true
        }
        return false
       
    }
    
    
    
    func checkForVictory() -> String {
        // Horizontal Victory
        if board[0] == board[1] && board[0] == board[2] && board[0] != EMPTY {
            return board[0]
            
        }
        if board[3] == board[4] && board[3] == board[5] && board[3] != EMPTY {
            return board[3]
            
        }
        if board[6] == board[7] && board[6] == board[8] && board[6] != EMPTY {
            return board[6]
            
        }
        
        // Vertical Victory
        if board[0] == board[3] && board[0] == board[6] && board[0] != EMPTY {
            return board[0]
            
        }
        if board[1] == board[4] && board[1] == board[7] && board[1] != EMPTY {
            return board[1]
            
        }
        if board[2] == board[5] && board[2] == board[8] && board[2] != EMPTY {
            return board[2]
            
        }
        
        // Diagonal Victory
        if board[0] == board[4] && board[0] == board[8] && board[0] != EMPTY {
            return board[0]
            
        }
        if board[2] == board[4] && board[2] == board[6] && board[2] != EMPTY {
            return board[2]
            
        }
        
        return EMPTY
        
    }
    
    
    func fullBoard() -> Bool {
        for marker in board {
            if marker == EMPTY {
                return false
            }
        }
        return true
    }
    
    
    
    func resetBoard() {
        
    board = ["_", "_", "_", "_", "_", "_", "_", "_", "_"]
        
        
    }
    
    func AIPLayer() -> Int {
        
        let position = board
        
        
        var randomInt = Int.random(in: 0...8)
        
        //Saves randomNumber in marker
        var marker = position[randomInt]
        
        
        print("AI Looking for empty place: \(randomInt) ")
        
        
        while marker != EMPTY {
            
            randomInt = Int.random(in: 0...8 )
            
            marker = position[randomInt]
            
        }
        if marker == EMPTY {
            print("Took place: \(randomInt)")
            board[randomInt] = CIRCLE
            print(board)
            
         
        }
       return randomInt
    }
    
    
    
    
    

    
        
    
    
    
    
}

    
    
   
    
    



