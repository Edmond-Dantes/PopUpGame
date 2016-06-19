//
//  Options.swift
//  PopUpGame
//
//  Created by Edmond Akpan on 6/13/16.
//  Copyright © 2016 Edmond Akpan. All rights reserved.
//

import Foundation
import UIKit

class Options{
    
    let maxChances:Int = 30
    
    let defaultPhoto = UIImage(named: "surprisedFace")!
    var isDefaultPhoto:Bool = true
    
    private var numberOfChances:Int = 10
    private var popUpImage:UIImage? = UIImage(named: "surprisedFace")
    
    //var safeTouchSound
    //var popUpSound
    
    func getNumberofChances()->Int{
        return numberOfChances
    }
    
    func updateNumberOfChances(chances:Int){
        self.numberOfChances = chances
    }
    
    func getPopUpImage()-> UIImage?{
        return popUpImage
    }
    
    func updatePopUpImage(image:UIImage){
        self.popUpImage = image
    }
    
    //func updateSafeTouchSound(sound){}
    
    //func updatePopUpSound(sound){}
    
    
    
}