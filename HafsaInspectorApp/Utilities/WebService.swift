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
    case httpBasicAuth
    case httpTokenAuth
}

 enum HTTPRequestContentType {
    case httpJsonContent
    case httpMultipartContent
}

 enum HTTPRequestMethod {
    case get
    case post
    case put
    case upload
}

let chaptersAndEstablishmentsEndpoint = "https://spreadsheets.google.com/feeds/list/1j1-OsdS5av9WFLswdm23s0bkHyv8e73UmKlbT31Eddw/od6/public/basic?alt=json"


class WebService: NSObject {
    typealias CompletionHandler = (Bool?, NSError?) -> Void

    func getChaptersAndEstablishments(_ completion:@escaping CompletionHandler) {
        let url = URL(string: chaptersAndEstablishmentsEndpoint)
        let request: NSMutableURLRequest = NSMutableURLRequest(url:url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        HTTPHelper().sendRequest(request as URLRequest) { (data:Data?, error:Error?) in
            if let error = error {
                print("error \(error)")
//                if error.code == -999 { return }
                completion(false,error as NSError?)
                
            } else if let resData = data {
                
               let result = self.parseJSON(resData)
                let object = result as NSDictionary!
                
                let arr: NSMutableArray = []
                let json = object! as NSDictionary
                let feed = json.object(forKey: "feed") as! NSDictionary
                let entries = feed.object(forKey: "entry") as! NSArray
                for dict in entries {
                    arr.add(dict)
                }
                
                let data: NSMutableArray = []
                for dict in arr {
                    let titleDict = (dict as AnyObject).object(forKey: "title") as! NSDictionary
                    let title = titleDict.object(forKey: "$t") as! String
                    let estDict = (dict as AnyObject).object(forKey: "content") as! NSDictionary
                    let ests = estDict.object(forKey: "$t") as! NSString!
                    let establishmentString = ests?.replacingOccurrences(of: "establishments:", with: "")
                    let establishmentsArr = establishmentString?.characters.split{$0 == ","}.map(String.init)
                    data.add([title:establishmentsArr])
                    
                }
                DispatchQueue.main.async {
                    HIManager.sharedClient().data = data
                    completion(true, nil)
                }
            }
        } //as! (Data?, NSError?) -> Void
    }
    
    
    func parseJSON(_ data: Data) -> [String: AnyObject]? {
        
        do {
            // Try parsing some valid JSON
            let json = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject]
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
        
         func sendRequest(_ request: URLRequest, completion:@escaping (Data?, Error?) -> Void) -> () {
            // Create a NSURLSession task
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?,  response: URLResponse?, error: Error?) in
                if error != nil {
                    DispatchQueue.main.async(execute: { () -> Void in
                        print("sendRequest error")
                        completion(data, error)
                    })
                    
                    return
                }
                
                DispatchQueue.main.async(execute: { () -> Void in
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                            completion(data, nil)
                        } else {
                            let responseError : NSError = NSError(domain: "HTTPHelperError", code: httpResponse.statusCode, userInfo: nil)
                            print("sendRequest error 2")
                            completion(data, responseError)
                        }
                    }
                })
            })
            
            // start the task
            task.resume()
        }
        
         func getErrorMessage(_ error: NSError) -> NSString {
            var errorMessage : NSString
            
            // return correct error message
            if error.domain == "HTTPHelperError" {
                let userInfo = error.userInfo as NSDictionary!
                errorMessage = userInfo?.value(forKey: "message") as! NSString
            } else {
                errorMessage = error.description as NSString
            }
            
            return errorMessage
        }
    }

    
}
