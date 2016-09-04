//
//  WebService.swift
//  HafsaInspectorApp
//
//  Created by Sameer Siddiqui on 9/2/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

//enum RequestType {
//    case get
//    case post
//}



 enum HTTPRequestAuthType {
    case HTTPBasicAuth
    case HTTPTokenAuth
}

 enum HTTPRequestContentType {
    case HTTPJsonContent
    case HTTPMultipartContent
}

 enum HTTPRequestMethod {
    case GET
    case POST
    case PUT
    case UPLOAD
}

let chaptersAndEstablishmentsEndpoint = "https://spreadsheets.google.com/feeds/list/1j1-OsdS5av9WFLswdm23s0bkHyv8e73UmKlbT31Eddw/od6/public/basic?alt=json"


class WebService: NSObject {
    typealias CompletionHandler = (Bool!, NSError!) -> Void

    func getChaptersAndEstablishments(completion:CompletionHandler) {
        let url = NSURL(string: chaptersAndEstablishmentsEndpoint)
        let request: NSMutableURLRequest = NSMutableURLRequest(URL:url!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        HTTPHelper().sendRequest(request) { (data:NSData!, error:NSError!) in
            if let error = error {
                print("error \(error)")
                if error.code == -999 { return }
                completion(false,error)
                
            } else if let resData = data {
                
               let result = self.parseJSON(resData)
                let object = result as NSDictionary!
                
                let arr: NSMutableArray = []
                let json = object as NSDictionary
                let feed = json.objectForKey("feed") as! NSDictionary
                let entries = feed.objectForKey("entry") as! NSArray
                for dict in entries {
                    arr.addObject(dict)
                }
                
                let data: NSMutableArray = []
                for dict in arr {
                    let titleDict = dict.objectForKey("title") as! NSDictionary
                    let title = titleDict.objectForKey("$t") as! String
                    let estDict = dict.objectForKey("content") as! NSDictionary
                    let ests = estDict.objectForKey("$t") as! NSString!
                    let establishmentString = ests.stringByReplacingOccurrencesOfString("establishments:", withString: "")
                    let establishmentsArr = establishmentString.characters.split{$0 == ","}.map(String.init)
                    data.addObject([title:establishmentsArr])
                    
                }
                dispatch_async(dispatch_get_main_queue()) {
                    HIManager.sharedClient().data = data
                    completion(true, nil)
                }
            }
        }
    }
    
    
    func parseJSON(data: NSData) -> [String: AnyObject]? {
        
        do {
            // Try parsing some valid JSON
            let json = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue: 0)) as? [String: AnyObject]
            return json
        }
        catch let error as NSError {
            // Catch fires here, with an NSErrro being thrown from the JSONObjectWithData method
            print("A JSON parsing error occurred, here are the details:\n \(error)")
        }
        
        return nil
    }
    

    


  
    
    /**
     *   Convenience wrapper class of Http requests.  Handles errors and notifies handlers
     */
    
     struct HTTPHelper {
        
         init() {
            
        }
        
        /**
         
         Handle an NSURLRequest
         
         - Parameter request: Pass in an NSUR
         - Parameter completion: Completion handler that will pass back data and error tuple
         
         */
        
         func sendRequest(request: NSURLRequest, completion:(NSData!, NSError!) -> Void) -> () {
            // Create a NSURLSession task
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request) { (data: NSData?,  response: NSURLResponse?, error: NSError?) in
                if error != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        print("sendRequest error")
                        completion(data, error)
                    })
                    
                    return
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if let httpResponse = response as? NSHTTPURLResponse {
                        if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                            completion(data, nil)
                        } else {
                            let responseError : NSError = NSError(domain: "HTTPHelperError", code: httpResponse.statusCode, userInfo: nil)
                            print("sendRequest error 2")
                            completion(data, responseError)
                        }
                    }
                })
            }
            
            // start the task
            task.resume()
        }
        
         func getErrorMessage(error: NSError) -> NSString {
            var errorMessage : NSString
            
            // return correct error message
            if error.domain == "HTTPHelperError" {
                let userInfo = error.userInfo as NSDictionary!
                errorMessage = userInfo.valueForKey("message") as! NSString
            } else {
                errorMessage = error.description
            }
            
            return errorMessage
        }
    }

    
}
