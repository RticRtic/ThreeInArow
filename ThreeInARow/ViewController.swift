//
//  ViewController.swift
//  ThreeInARow
//
//  Created by Jesper Söderling on 2021-11-23.
//

import UIKit

class ViewController: UIViewController {
    
    
    enum Turn {
        case Circle
        case Cross
    }
    

    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var CIRCLE = "O"
    var CROSS = "X"
    
    var crossScore = 0
    var circleScore = 0
    
    // Array of buttons
    var board = [UIButton]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBoard()
        
        
        
    }
    // Adds the buttons in the boards Array
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }

    @IBAction func tapRecognizer(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(CROSS) {
            
            crossScore += 1
            resultAlert(title: "X Win!")
            
        }
        if checkForVictory(CIRCLE) {
            
            circleScore += 1
            resultAlert(title: "O Win!")
        }
        
        if fullBoard() {
           resultAlert(title: "Draw")
        }
        
    }
    
    func checkForVictory(_ s :String) -> Bool {
        // Horizontal victory
        if thisSymbol(a1,s) && thisSymbol(a2,s) && thisSymbol(a3,s) {
            return true
        }
        if thisSymbol(b1,s) && thisSymbol(b2,s) && thisSymbol(b3,s) {
            return true
        }
        if thisSymbol(c1,s) && thisSymbol(c2,s) && thisSymbol(c3,s) {
            return true
        }
        
        // Vertical victory
        if thisSymbol(a1,s) && thisSymbol(b1,s) && thisSymbol(c1,s) {
            return true
        }
        if thisSymbol(a2,s) && thisSymbol(b2,s) && thisSymbol(c2,s) {
            return true
        }
        if thisSymbol(a3,s) && thisSymbol(b3,s) && thisSymbol(c3,s) {
            return true
        }
        // Diagonal victory
        if thisSymbol(a1,s) && thisSymbol(b2,s) && thisSymbol(c3,s) {
            return true
        }
        if thisSymbol(a3,s) && thisSymbol(b2,s) && thisSymbol(c1,s) {
            return true
        }
       
        return false
    }
    
    // If the symbol is O or X in a row it return true
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        
        return button.title(for: .normal) == symbol
    }
    
    
    
    // Handler
    func resultAlert(title: String) {
        
        let message = "\nCircle " + String(circleScore) + "\n\nCrosses " + String(crossScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in self.resertBoard() }))
        self.present(ac,animated: true)
        
    }
    
    // Set all the button back to nil
    func resertBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        // Start a new round, player O starting
        if firstTurn == Turn.Circle {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
            
        }
        else if firstTurn == Turn.Cross {
            firstTurn = Turn.Circle
            turnLabel.text = CIRCLE
            
        }
        currentTurn = firstTurn
    }
    
    
    
    // Check if there an empty space on the board
    func fullBoard() -> Bool {
        for button in board {
            
            // If it founds an empty space
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    
    // Puts data in sender
    func addToBoard(_ sender: UIButton) {
       
        if sender.title(for: .normal) == nil {
            
            if currentTurn == Turn.Circle {
                sender.setTitle(CIRCLE, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if currentTurn == Turn.Cross {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Circle
                turnLabel.text = CIRCLE
            }
            // Remove animation when a button already has 0 or X in it
            sender.isEnabled = false
            
    }
    
}

}
