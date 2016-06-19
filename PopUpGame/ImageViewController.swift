//
//  ViewController.swift
//  PopUpGame
//
//  Created by Edmond Akpan on 6/13/16.
//  Copyright © 2016 Edmond Akpan. All rights reserved.
//

import UIKit

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if j != i{
                swap(&self[i], &self[j])
            }
        }
    }
}



// Lucky Game Logic
class ImageViewController: UIViewController, UIGestureRecognizerDelegate {

    var waitTimer:NSTimeInterval = 0.5
    var timer:NSTimer?
    
    var touchFlag:Bool = false
    
    var luckyNumber = 1
    var touchCounter = 1
    var colorCounter = 0
    
    var colorArray:[UIColor] =
                    [.blueColor(),
                    .brownColor(),
                    .cyanColor(),
                    .greenColor(),
                    .magentaColor(),
                    .orangeColor(),
                    .purpleColor(),
                    .redColor(),
                    .whiteColor(),
                    .yellowColor()]
        
    
    
    weak var optionsData:Options?
    
    @IBOutlet weak var imageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = nil
        timer = NSTimer(timeInterval: waitTimer, target: self, selector: #selector(self.timerFireMethod(_:)), userInfo: nil, repeats: false)
        
        touchFlag = false
        
        self.colorArray.shuffle()
        imageButton.backgroundColor = colorArray[0]
        
        luckyNumber = randomNumber(optionsData!.getNumberofChances())
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func timerFireMethod(timer:NSTimer){
        touchFlag = false
        //imageButton.setImage(optionsData!.getPopUpImage(), forState: UIControlState.Normal)
    }
    
    
    private func randomNumber(maxNumber:Int)->Int{
        let randomNumber = Int(arc4random_uniform(UInt32(maxNumber)))
        return randomNumber + 1
    }
    
   
    @IBAction func tapAction(sender: AnyObject) {
        
        if !touchFlag{
        
            timer = nil
            timer = NSTimer(timeInterval: waitTimer, target: self, selector: #selector(self.timerFireMethod(_:)), userInfo: nil, repeats: false)
            NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSDefaultRunLoopMode)
            
            touchFlag = true
            if touchCounter == luckyNumber{
                imageButton.setImage(optionsData!.getPopUpImage(), forState: UIControlState.Normal)
            }
            
            touchCounter += 1
            if touchCounter > optionsData!.getNumberofChances(){
                touchCounter = 0
            }
            
            
            colorCounter += 1
            if colorCounter >= colorArray.count{
                colorCounter = 0
            }
            imageButton.backgroundColor = colorArray[colorCounter]
        
        }
    
    }
    
    
    
}

