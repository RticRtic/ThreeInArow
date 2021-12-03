//
//  StartViewController.swift
//  ThreeInARow
//
//  Created by Jesper Söderling on 2021-11-29.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var xEnterName: UITextField!
    @IBOutlet weak var oEnterName: UITextField!
    
    
    let segueStartGameId = "startGameIdentifier"
    let segueStartGameAIId = "startGameAIIdentifier"
    
    var playerVSplayer: Bool = false
    var playerVSAi: Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
    }
    
    @IBAction func startGameButton(_ sender: UIButton) {
        
       performSegue(withIdentifier: segueStartGameId, sender: self)
        
        
    
        
    }
    
    @IBAction func startGameAgainsAIButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: segueStartGameAIId, sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueStartGameId {
            let destinationVC = segue.destination as! ViewController
            destinationVC.recivingMessageX = xEnterName.text
            destinationVC.recivingMessageO = oEnterName.text
            destinationVC.recivingPlayerVSplayer = playerVSplayer
            
        }
        else if segue.identifier == segueStartGameAIId {
            let destinationVC = segue.destination as! ViewController
            destinationVC.recivingPlayerVSAi = playerVSAi
            
        }
    }
    
   
   

}
