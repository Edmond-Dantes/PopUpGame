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
    
    var pListOptionsDict:[String:AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(readPropertyList())

        pListOptionsDict = readPropertyList()
        print(pListOptionsDict)
        optionsData!.updateNumberOfChances(pListOptionsDict["chances"] as! Int)
        
        numberOfChangesPicker.dataSource = self
        numberOfChangesPicker.delegate = self
        
        let startNumber = optionsData!.getNumberofChances()
        numberOfChangesPicker.selectRow(startNumber - 1, inComponent: 0, animated: false)
        
        popUpImagePreview.image = optionsData!.getPopUpImage()
        
        //imagePickerController.sourceType = .PhotoLibrary
        //imagePickerController.delegate = self
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        var loadData:[String:AnyObject] = [:]
        loadData["chances"] = optionsData!.getNumberofChances()
        loadData["image"] = "baby" //change later to have the file name of the images
        
        loadPropertyList(loadData)
        
    }
    
    func readPropertyList()->[String:AnyObject]{
        
        let fileManager = NSFileManager.defaultManager()
        
        //var format = NSPropertyListFormat.XMLFormat_v1_0 //format of the property list
        var plistData:[String:AnyObject] = [:]  //our data
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let plistDestinationPath:String? = (documentDirectory as NSString).stringByAppendingPathComponent("OptionsSettings.plist")
        let plistSourcePath:String? = NSBundle.mainBundle().pathForResource("OptionsSettings", ofType: "plist")!
        
        if !fileManager.fileExistsAtPath(plistDestinationPath!){
            plistData = NSDictionary(contentsOfFile: plistSourcePath!) as! [String : AnyObject]
            
            do{
                try fileManager.copyItemAtPath(plistSourcePath!, toPath: documentDirectory)
            }catch{
                print("error copying options plist from bundle to directory: \(error)")
            }
            
        }else{
            plistData = NSDictionary(contentsOfFile: plistDestinationPath!) as! [String : AnyObject]
        }
        
        
        //let plistXML = fileManager.contentsAtPath(plistPath!)!

        /*
        do{
            plistData = try NSPropertyListSerialization.propertyListWithData(plistXML,
                                                                             options: .MutableContainersAndLeaves,
                                                                             format: &format)
                as! [String:AnyObject]
        }
        catch{
            print("Error reading plist: \(error), format: \(format)")
        }
        */

        return plistData
    }
    
    func loadPropertyList(propertyListData:AnyObject){
        //let name = "OptionsSettings"
        //let format = NSPropertyListFormat.XMLFormat_v1_0
        //var plistData:NSData = NSData()
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let plistPath:String? = (documentDirectory as NSString).stringByAppendingPathComponent("OptionsSettings.plist")
        
        //let plistPath = (dir as NSString).stringByAppendingPathComponent("OptionsSettings.plist")
       /*
        do{
            plistData = try NSPropertyListSerialization.dataWithPropertyList(propertyListData, format: format , options: 0)
        }
        catch{
            print("Error writing to plist: \(error), format: \(format)")
        }
        */
        
        (propertyListData as! NSDictionary).writeToFile(plistPath!, atomically: true)
        /*
        do{
            try plistData.writeToFile(plistPath!, options: NSDataWritingOptions.DataWritingAtomic)
        }
        catch{
            print("Error writing to plist: \(error), format: \(format)")
        }
        */
        
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
        /*
        var loadData:[String:AnyObject] = [:]
        loadData["chances"] = optionsData!.getNumberofChances()
        loadData["image"] = "baby" //change later to have the file name of the images
        
        loadPropertyList(loadData)
 */
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
