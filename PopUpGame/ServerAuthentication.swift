//
//  ServerAuthentication.swift
//  PopUpGame
//
//  Created by Edmond Akpan on 6/20/16.
//  Copyright © 2016 Edmond Akpan. All rights reserved.
//

import Foundation
import UIKit

class ServerAuthentication: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate{
    
    
    typealias callBackBlock = (result: String, error: String?) -> ()
    var callBack: callBackBlock = {
        (resultString, error) -> Void in
        if error == nil{
            //print(resultString)
        }else {
            print(error)
        }
    }
    
    func httpAuthentication(request: NSMutableURLRequest!){
        UIApplication.sharedApplication().openURL(request.URL!)
    }
    
    func httpPost(request:NSMutableURLRequest!) -> Dictionary<String, AnyObject>?{
        let configuration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue:NSOperationQueue.mainQueue())
        
        var jsonDictionary:Dictionary<String, AnyObject>? = nil
        
        request.HTTPMethod = "POST"
        
        session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) in
            
            if let responseData = data{
                do{
                    
                    //print(data.debugDescription )
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    //print(json)
                    
                    if let dict = json as? Dictionary<String, AnyObject>{
                        print("json Dict working: \(dict.debugDescription)")
                        
                        jsonDictionary = dict
                    }
                    
                    
                    
                    
                } catch{
                    print("Could not serialize")
                }
                
            }
            
            }.resume()
        
        
        return jsonDictionary
        
    }
    
    func httpGet(request: NSMutableURLRequest!, callBack: (String, String?) -> Void) -> Dictionary<String, AnyObject>?{
        
        let configuration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue:NSOperationQueue.mainQueue())
        
        var jsonDictionary:Dictionary<String, AnyObject>? = nil
        
        request.HTTPMethod = "GET"
        
        session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) in
            
            if let responseData = data{
                do{
                    
                    //print(data.debugDescription )
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    //print(json)
                    
                    if let dict = json as? Dictionary<String, AnyObject>{
                        print("json Dict working: \(dict.debugDescription)")
                        
                        jsonDictionary = dict
                    }
                    
                    
                    
                    
                } catch{
                    print("Could not serialize")
                }
                
            }
            
            }.resume()
        
        
        return jsonDictionary
        
        
        /*
        //let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        //let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue:NSOperationQueue.mainQueue())
        
        
        
        let task = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) in
            
            if error == nil{
                let result = NSString(data: data!, encoding: NSASCIIStringEncoding)! as String
                callBack(result, nil)
            }else {
                callBack("", error?.localizedDescription)
            }
            
        }
        task.resume()
 
 */
        
    }
    
    
    
    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        
        print(challenge.protectionSpace.authenticationMethod)
        
        //session.
        
        completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!))
        
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, willPerformHTTPRedirection response: NSHTTPURLResponse, newRequest request: NSURLRequest, completionHandler: (NSURLRequest?) -> Void) {
        
        
        let newRequest : NSURLRequest? = request
        
        completionHandler(newRequest)
    }
    
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        
        print("Total Bytes Sent: \(bytesSent)")
        
        
    }
    
}