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
        case AI
    }
    
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var turnName: UILabel!
    
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
    var AI = "O"
    
    var firstTurnMVC = "CROSS"
    var currenTurn = "CROSS"
    var secondTurnMVC = "CIRCLE"
    
    
    var crossScore = 0
    var circleScore = 0
    var aIScore = 0
    
    var recivingMessageX: String? = ""
    var recivingMessageO: String? = ""
    
    var recivingPlayerVSplayer: Bool? // false
    var recivingPlayerVSAi: Bool? // true
    
    
    let game = Game()
    
    // Array of buttons
    var board = [UIButton]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        turnName.text = recivingMessageX
        
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
        
        
        
        let pos = sender.tag
        let allowed = game.addToBoard(position: pos, marker: CROSS)
        
        if allowed {
            addToBoard(sender)
        }
        
       let winner = game.checkForVictory()
        if winner == CROSS {
            
        }
            
        
       
        
       
        /*
        addToBoard(sender)
        
        
            
            if checkForVictory(CROSS) {
                
                guard let nameX = recivingMessageX else {return}
                crossScore += 1
                resultAlert(title:"\(nameX) X Win!")
                
            }
            
            if checkForVictory(CIRCLE) {
                
                guard let nameO = recivingMessageO else {return}
                circleScore += 1
                resultAlert(title:"\(nameO) Win!")
            }
        
    
            if fullBoard() {
                resultAlert(title: "Draw")
            }
        
        
      
            if checkForVictory(CROSS) {
                guard let nameX = recivingMessageX else {return}
                crossScore += 1
                resultAlert(title:"\(nameX) X Win!")
            }
        
     
            if checkForVictory(CIRCLE) {
                aIScore += 1
                resultAlert(title: "AI Win!")
            }
        
       
       */
       
    }
    
    
    func checkForVictory(_ symbol :String) -> Bool {
        // Horizontal victory
        if thisSymbol(a1,symbol) && thisSymbol(a2,symbol) && thisSymbol(a3,symbol) {
            
            return true
        }
        if thisSymbol(b1,symbol) && thisSymbol(b2,symbol) && thisSymbol(b3,symbol) {
            return true
        }
        if thisSymbol(c1,symbol) && thisSymbol(c2,symbol) && thisSymbol(c3,symbol) {
            return true
        }
        
        // Vertical victory
        if thisSymbol(a1,symbol) && thisSymbol(b1,symbol) && thisSymbol(c1,symbol) {
            return true
        }
        if thisSymbol(a2,symbol) && thisSymbol(b2,symbol) && thisSymbol(c2,symbol) {
            return true
        }
        if thisSymbol(a3,symbol) && thisSymbol(b3,symbol) && thisSymbol(c3,symbol) {
            return true
        }
        // Diagonal victory
        if thisSymbol(a1,symbol) && thisSymbol(b2,symbol) && thisSymbol(c3,symbol) {
            return true
        }
        if thisSymbol(a3,symbol) && thisSymbol(b2,symbol) && thisSymbol(c1,symbol) {
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
        guard let titleX = recivingMessageX else {return}
        guard let titleO = recivingMessageO else {return}
        
        if recivingPlayerVSplayer == false {
            let message = "\n\(titleO) " + String(circleScore) + "\n\n\(titleX) " + String(crossScore)
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in self.resertBoard()}))
            self.present(ac,animated: true)
        }
        else if recivingPlayerVSAi == true {
            let message = "\nAI " + String(aIScore) + "\n\nPlayer " + String(crossScore)
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in self.resertBoard()}))
            self.present(ac,animated: true)
        }
        
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
    // title = if the button has O, X or Nil on it
    func addToBoard(_ sender: UIButton) {
        
            if recivingPlayerVSplayer == false {
                
                if currentTurn == Turn.Cross {
                    sender.setTitle(CROSS, for: .normal)
                    currentTurn = Turn.Circle
                    turnLabel.text = CIRCLE
                    turnName.text = recivingMessageO
                    
                }
                else if currentTurn == Turn.Circle {
                    sender.setTitle(CIRCLE, for: .normal)
                    currentTurn = Turn.Cross
                    turnLabel.text = CROSS
                    turnName.text = recivingMessageX
                }
                sender.isEnabled = false
                
            
            
            
        }
        if recivingPlayerVSAi == true {
           
                print("Sender title is: \(sender.title(for: .normal))")
                print("PlayerVS AI : \(recivingPlayerVSAi)")
                currentTurn = Turn.Cross
                print("Current turn: \(currentTurn)")
                sender.setTitle(CROSS, for: .normal)
                sender.isEnabled = false
                
                AIPLayer()
                
            
        }
        
    }
    
    
    
    
    
    
    func AIPLayer() {
        
        let buttons = [a1, a2, a3, b1, b2, b3, c1 ,c2 ,c3]
        
        
        var randomInt = Int.random(in: 0...8)
        
        //Saves the randomNumber in a UIButton
        var button = buttons[randomInt]
        
        
        print("AI place: \(randomInt) ")
        
        
        while !isFree(button: button) {
            
            randomInt = Int.random(in: 0...8 )
           
            button = buttons[randomInt]

        }
        
        
        button?.setTitle(CIRCLE, for: .normal)
        button?.isEnabled = false
       
    }
    
    func isFree(button : UIButton?) -> Bool {
   
        return button?.title(for: .normal) == nil
        
        
    }
    
    
}





/*
 if currentTurn == Turn.Cross {
 sender.setTitle(CROSS, for: .normal)
 currentTurn = Turn.Circle
 turnLabel.text = recivingMessageX
 turnName.text = CIRCLE
 }
 else if currentTurn == Turn.Circle {
 sender.setTitle(CIRCLE, for: .normal)
 currentTurn = Turn.Cross
 turnLabel.text = recivingMessageO
 turnName.text = CROSS
 */
