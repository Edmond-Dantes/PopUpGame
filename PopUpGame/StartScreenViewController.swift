//
//  StartScreenViewController.swift
//  PopUpGame
//
//  Created by Edmond Akpan on 6/13/16.
//  Copyright © 2016 Edmond Akpan. All rights reserved.
//

import UIKit
import GoogleMobileAds

var accessToken:String? = nil
let myClientId = "fUqUQRc2tT"
let mySecret = "QbWpagVA9D6qGPa2uhW86N"
let myUrl = "PopUpGame://after_oauth"
let urlString = "https://api.quizlet.com/2.0/sets/415?client_id=fUqUQRc2tT&whitespace=1"
let authorizeUrl = "https://quizlet.com/authorize?client_id=\(myClientId)&response_type=code&scope=read%20write_set"
let tokenUrl = "https://api.quizlet.com/oauth/token?"
let encodedString = "ZlVxVVFSYzJ0VDpRYldwYWdWQTlENnFHUGEydWhXODZO"

let userPassword = "\(myClientId):\(mySecret)"

let serverRequestObject = ServerAuthentication()


class StartScreenViewController: UIViewController{

    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var webRequestButton: UIButton!
    
    @IBOutlet weak var bannerView: GADBannerView!
   
    
    
    
    
    var optionsData:Options = Options()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" 
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())
        

        weak var serverRequest = serverRequestObject
        let requestAuthorization = NSMutableURLRequest(URL: NSURL(string: "https://quizlet.com/authorize?response_type=code&client_id=\(myClientId)&scope=read&state=124214asdf&redirect_uri=\(myUrl)")!)
        
        
        //opens quizlet in Browser: response in func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject)
        
//        serverRequest!.httpAuthentication(requestAuthorization)
       
        
        
        
        /*
        test.httpGet(request) { (resultString, error) in
            test.callBack(result: resultString, error: error)
        }
        */
        
        /*
        session.dataTaskWithURL(url) { (data:NSData?, response:NSURLResponse?, error:NSError?) in
            
            if let responseData = data{
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    //print(json)
                    
                    if let dict = json as? Dictionary<String, AnyObject>{
                        //print("json Dict working: \(dict.debugDescription)")
                        if let termsInfoArray = dict["terms"] as? NSArray{
                            //print("terms: \(termsArray.debugDescription)")
                            var termArray:[String] = []
                            for singleTermInfoDict in termsInfoArray{
                                let term = singleTermInfoDict["term"] as! String
                                print("test is good: \(term)")
                                termArray.append(term)
                                
                            }
                            
                           
                        }
                    }
                    
                    
                    
                    
                } catch{
                    print("Could not serialize")
                }
                
            }
            
        }.resume()
        
        
    */
        
    }
 
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Action
    
    @IBAction func optionButtonAction(sender: AnyObject) {
        self.performSegueWithIdentifier("optionsSegue", sender: nil)
        
    }
    
    @IBAction func startButtonAction(sender: AnyObject) {
        self.performSegueWithIdentifier("startSegue", sender: nil)
        
    }
    
    
    @IBAction func webRequestAction(sender: AnyObject) {
        
        //opens quizlet in Browser: response in func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject)
        
        //        serverRequest!.httpAuthentication(requestAuthorization)
        
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
