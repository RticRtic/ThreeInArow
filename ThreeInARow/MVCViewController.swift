//
//  MVCViewController.swift
//  ThreeInARow
//
//  Created by Jesper Söderling on 2021-12-03.
//

import UIKit

class Game {
    
    enum Turn {
        case Cross
        case Circle
        case AI
    }
    
    private var board = ["_", "_", "_", "_", "_", "_", "_", "_", "_"]
    
    var CROSS = "X"
    var CIRCLE = "O"
    var EMPTY = "_"
    
    var currentTurn = Turn.Cross
    var firstTurn = Turn.Cross
    
    var recivingPlayerVSplayer: Bool? // false
    var recivingPlayerVSAi: Bool? // true
    
    
    
    func addToBoard(position: Int, marker: String) -> Bool  {
        
        let positionAsString = String(position)
        
        if positionAsString == EMPTY {
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
    
    // Checks if there an empty space on the board
    func fullBoard() -> Bool {
        for markers in board {
            
            if markers == CROSS && markers == CIRCLE {
                return true
            }
        }
        return false
    }
    
    func resetBoard() {
        for marker in board {
            if marker == EMPTY && marker == CROSS && marker == CIRCLE {
                board.append(EMPTY)
            }
        }
    }
    
    
}
