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
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func startGameButton(_ sender: UIButton) {
        
     performSegue(withIdentifier: segueStartGameId, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueStartGameId {
            let destinationVC = segue.destination as! ViewController
            destinationVC.recivingMessageX = xEnterName.text
            destinationVC.recivingMessageO = oEnterName.text
            
        }
    }
    
    
    

}
