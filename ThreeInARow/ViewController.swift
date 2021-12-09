//
//  ViewController.swift
//  ThreeInARow
//
//  Created by Jesper Söderling on 2021-11-23.
//

import UIKit

class ViewController: UIViewController {
    
    
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
    
    
    
    var CIRCLE = "O"
    var CROSS = "X"
    var AI = "O"
    
    var firstTurn = "X"
    var currentTurn = "X"
    
    
    
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
        
        if recivingPlayerVSplayer == false {
        
        let pos = sender.tag
        let allowed = game.addToBoard(position: pos, marker: currentTurn)
        
        print(" pos: \(pos) allowed: \(allowed)")
        if allowed {
            setPlayerTitle(sender)
        }
        
        changeTurn()
        
        
        let winner = game.checkForVictory()
        
        if winner == CROSS {
            guard let nameX = recivingMessageX else {return}
            crossScore += 1
            resultAlert(title: "\(nameX) with X Win!")
        }
        else if winner == CIRCLE {
            guard let nameO = recivingMessageO else {return}
            circleScore += 1
            resultAlert(title:"\(nameO) with O Win!")
        }
        if game.fullBoard() {
            resultAlert(title: "Draw!")
        }
        
        
        }
        
        if recivingPlayerVSAi == true {
            let pos = sender.tag
            let allowed = game.addToBoard(position: pos, marker: currentTurn)
            
            if allowed {
                setPlayerTitle(sender)
                _ = game.AIPLayer()
                setAiTitle(position: pos)
            }
            
           
        }
        
        let winner = game.checkForVictory()
        if winner == CROSS {
            crossScore += 1
            resultAlert(title: "Player with X Win!")
        }
        else if winner == CIRCLE {
            aIScore += 1
            resultAlert(title: "AI with O Win!")
        }
        
        
    }
    
    func changeTurn() {
        if currentTurn == CROSS {
            currentTurn = CIRCLE
            turnLabel.text = CIRCLE
            turnName.text = recivingMessageO
            
        }
        else if currentTurn == CIRCLE {
            currentTurn = CROSS
            turnLabel.text = CROSS
            turnName.text = recivingMessageX
        }
        
    }
    
    
    // Handler
    func resultAlert(title: String) {
        guard let titleX = recivingMessageX else {return}
        guard let titleO = recivingMessageO else {return}
        
        if recivingPlayerVSplayer == false {
            let message = "\n\(titleO) " + String(circleScore) + "\n\n\(titleX) " + String(crossScore)
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
                print("reset...")
                // Resets board
                self.game.resetBoard()
                self.refreshButtons()
                
            }))
            self.present(ac,animated: true)
        }
        else if recivingPlayerVSAi == true {
            let message = "\nAI " + String(aIScore) + "\n\nPlayer " + String(crossScore)
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
                // Resets board
                self.game.resetBoard()
                self.refreshButtons()
                
            }))
            self.present(ac,animated: true)
        }
        
    }
    

    func refreshButtons() {
        print("buttons: \(board.count)")
        for button in board {
            button.setTitle("", for: .normal)
            button.isEnabled = true
        }
        // Start a new round, player O starting
        if firstTurn == CROSS {
            firstTurn = CIRCLE
        }
        
        
    }
    
    func setAiTitle(position: Int) {
        if position == 0 {
            a1.setTitle(CIRCLE, for: .normal)
        }

        
        
    }
    
    
    
    // Sets the Playerbutton title to X or O
    func setPlayerTitle(_ sender: UIButton) {
        
        print("add \(currentTurn)")
        sender.setTitle(currentTurn, for: .normal)
        
        
        /*         if recivingPlayerVSplayer == false {
         
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
         
         
         } */
        
    }
    
    
    
    
    
    /*
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
    */
    
}




