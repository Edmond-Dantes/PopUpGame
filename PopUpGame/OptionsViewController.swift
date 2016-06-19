//
//  OptionsViewController.swift
//  PopUpGame
//
//  Created by Edmond Akpan on 6/13/16.
//  Copyright © 2016 Edmond Akpan. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Outlet
    
    @IBOutlet weak var numberOfChangesPicker: UIPickerView!
    @IBOutlet weak var popUpImageChangeButton: UIButton!
    @IBOutlet weak var popUpImagePreview: UIImageView!
    
    weak var optionsData:Options?
    
    let imagePickerController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numberOfChangesPicker.dataSource = self
        numberOfChangesPicker.delegate = self
        
        let startNumber = optionsData!.getNumberofChances()
        numberOfChangesPicker.selectRow(startNumber - 1, inComponent: 0, animated: false)
        
        popUpImagePreview.image = optionsData!.getPopUpImage()
        
        //imagePickerController.sourceType = .PhotoLibrary
        //imagePickerController.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PickerView
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return optionsData!.maxChances
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        optionsData!.updateNumberOfChances(row + 1)
    }
    
    
    // MARK: - ImageChangeButton
    
    @IBAction func imageChangeButtonAction(sender: AnyObject) {
        
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        optionsData!.updatePopUpImage(selectedImage)
        self.popUpImagePreview.image = selectedImage
        
        optionsData!.isDefaultPhoto = false
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - Action
    
    
    
    
    @IBAction func defaultButtonAction(sender: AnyObject) {
        
        if !optionsData!.isDefaultPhoto{
            optionsData!.updatePopUpImage(optionsData!.defaultPhoto)
            self.popUpImagePreview.image = optionsData!.defaultPhoto
            optionsData!.isDefaultPhoto = true
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
