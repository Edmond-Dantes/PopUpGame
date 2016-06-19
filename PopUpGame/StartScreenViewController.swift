//
//  StartScreenViewController.swift
//  PopUpGame
//
//  Created by Edmond Akpan on 6/13/16.
//  Copyright © 2016 Edmond Akpan. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    @IBOutlet weak var OptionsButton: UIButton!
    @IBOutlet weak var StartButton: UIButton!
    
    var optionsData:Options = Options()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Action
    
    @IBAction func OptionButtonAction(sender: AnyObject) {
        self.performSegueWithIdentifier("optionsSegue", sender: nil)
        
    }
    
    @IBAction func StartButtonAction(sender: AnyObject) {
        self.performSegueWithIdentifier("startSegue", sender: nil)
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier! == "optionsSegue" {
            
            let optionsVC = segue.destinationViewController as! OptionsViewController
            optionsVC.optionsData = self.optionsData
            
            
        }else if segue.identifier == "startSegue" {
            
            let luckyGameVC = segue.destinationViewController as! ImageViewController
            luckyGameVC.optionsData = self.optionsData
            
        }
        
        
        
        
        
        
        
    }
    

}
