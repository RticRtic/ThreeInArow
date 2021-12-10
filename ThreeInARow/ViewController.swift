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
    
    
    var firstTurn = "X"
    var currentTurn = "X"
    
    
    
    var crossScore = 0
    var circleScore = 0
    var aIScore = 0
    
    var recivingMessageX: String? = ""
    var recivingMessageO: String? = ""
    
    var recivingPlayerVSplayer: Bool? // false
    var recivingPlayerVSAi: Bool? // true
    
    var disablePlayerButton = false
    
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
        
        // Player VS Player
        if recivingPlayerVSplayer == false {
            
            let pos = sender.tag
            let allowed = game.addToBoard(position: pos, marker: currentTurn)
            
            print(" pos: \(pos) allowed: \(allowed)")
            if allowed {
                
                setPlayerTitle(sender)
                changeTurn()
            }
            
            
            
            
            let winner = game.checkForVictory()
            
            if winner == CROSS {
                guard let nameX = recivingMessageX else {return}
                crossScore += 1
                resultAlert(title: "\(nameX) Win!")
            }
            else if winner == CIRCLE {
                guard let nameO = recivingMessageO else {return}
                circleScore += 1
                resultAlert(title:"\(nameO) Win!")
            }
            if game.fullBoard() {
                resultAlert(title: "Draw!")
            }
            
            
        }
        
        // Player VS AI
        if recivingPlayerVSAi == true {
            if !disablePlayerButton {
                turnName.text = "PLAYER VS AI"
                
                let pos = sender.tag
                let allowed = game.addToBoard(position: pos, marker: currentTurn)
                
                print("pos: \(pos) allowed: \(allowed)")
                
                
                if allowed {
                    setPlayerTitle(sender)
                    turnLabel.text = CIRCLE
                    disablePlayerButton = true
                    // Check if there is a winner
                    var winner = game.checkForVictory()
                    if winner == CROSS {
                        crossScore += 1
                        resultAlert(title: "Player Win!")
                        return
                    }
                    // Check if draw
                    if game.fullBoard() {
                        resultAlert(title: "Draw!")
                        return
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [self] in
                        self.setAiTitle()
                        disablePlayerButton = false
                        self.turnLabel.text = CROSS
                        winner = game.checkForVictory()
                        if winner == CIRCLE {
                            aIScore += 1
                            resultAlert(title: "AI Win!")
                            
                        }
                        
                    })
                    
                    
                    
                }
            }
            
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
            disablePlayerButton = false
        }
        // player O starting
        if firstTurn == CROSS {
            firstTurn = CIRCLE
        }
        
        
    }
    // AiPlayer and sets buttontitle
    func setAiTitle() {
        let aiPosition = game.AIPLayer()
        
        
        switch aiPosition {
            
        case 0: a1.setTitle((CIRCLE), for: .normal)
        case 1: a2.setTitle((CIRCLE), for: .normal)
        case 2: a3.setTitle((CIRCLE), for: .normal)
        case 3: b1.setTitle((CIRCLE), for: .normal)
        case 4: b2.setTitle((CIRCLE), for: .normal)
        case 5: b3.setTitle((CIRCLE), for: .normal)
        case 6: c1.setTitle((CIRCLE), for: .normal)
        case 7: c2.setTitle((CIRCLE), for: .normal)
        case 8: c3.setTitle((CIRCLE), for: .normal)
            
        default:
            break
        }
        
    }
    
    
    
    // Sets the Playerbutton title to X or O
    func setPlayerTitle(_ sender: UIButton) {
        
        print("add \(currentTurn)")
        sender.setTitle(currentTurn, for: .normal)
        
        
        
        
        
    }
    
    
}


