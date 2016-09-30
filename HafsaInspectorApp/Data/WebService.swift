//
//  WebService.swift
//  HafsaInspectorApp
//
//  Created by Sameer Siddiqui on 9/2/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import Firebase


 enum HTTPRequestMethod {
    case get
    case post
    case put
    case upload
}

let googleFCMEndpoint = "https://fcm.googleapis.com/fcm/send"
let fcmAuthKey = "key=AIzaSyD53S4O97D1YYYxRb9t35geIgP8DR76IlA"

let chaptersAndEstablishmentsEndpoint = "https://spreadsheets.google.com/feeds/list/1j1-OsdS5av9WFLswdm23s0bkHyv8e73UmKlbT31Eddw/od6/public/basic?alt=json"

let googleFormLink = "https://docs.google.com/forms/d/e/1FAIpQLSeP4Rzd8ZWS-MFO8rCBUqRP_QQzLvMSMNK3t2s9YktcGmBXSA/formResponse"
let googleFormNameField = "entry.1968549434"
let googleFormYearField = "entry.1897376566_year"
let googleFormMonthField = "entry.1897376566_month"
let googleFormDayField = "entry.1897376566_day"
let googleFormHourField = "entry.1897376566_hour"
let googleFormMinuteField = "entry.1897376566_minute"
let googleFormEstablishmentField = "entry.975256468"
let googleFormZHMeatProcessorsField = "entry.1855455257"
let googleFormCrescentField = "entry.1054144217"
let googleFormHalalFarmsField = "entry.1678112188"
let googleFormHibaTradersField = "entry.784678828"
let googleFormMiscellaneousField = "entry.1965697433"
let googleFormNotesField = "entry.795200750"

class WebService: NSObject {
    typealias CompletionHandler = (Bool?, NSError?) -> Void

    func getChaptersAndEstablishments(_ completion:@escaping CompletionHandler) {
        let url = URL(string: chaptersAndEstablishmentsEndpoint)
        let request: NSMutableURLRequest = NSMutableURLRequest(url:url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        HTTPHelper().sendRequest(request as URLRequest) { (data:Data?, error:Error?) in
            if let error = error {
                completion(false,error as NSError?)
            }
            else if let resData = data {
                
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
        }
    }
    
    func getChaptersAndEstablishmentsFromDatabase(_ completion:@escaping CompletionHandler) {
        let ref: FIRDatabaseReference =  FIRDatabase.database().reference()
        
        ref.child("chapters").observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if value != nil {
                let chapters: NSArray = (value!.allKeys as NSArray)
                DispatchQueue.main.async {
                    HIManager.sharedClient().chapters = chapters.mutableCopy() as! NSMutableArray
                    HIManager.sharedClient().chaptersData = value!
                    completion(true, nil)
                }
    
            print(value)
            }
            else {
                let err = NSError(domain: "Could not retrieve user", code: 401, userInfo: nil)
                completion(false, err)
            }
            
            
        }) { (error) in
            completion(false, error as NSError?)
            print(error.localizedDescription)
        }
        
    }
    
    func sendToGoogleForms(name: String, year:String, month:String, day: String, hour: String, minute: String,establishment: String, zHProcessors:String, crescent: String, halalFarms: String, hibaTraders:String, miscellaneous:String, notes:String) {
        
        var postData = googleFormNameField + "=" + name
        postData += "&" + googleFormYearField + "=" + year
        postData += "&" + googleFormMonthField + "=" + month
        postData += "&" + googleFormDayField + "=" + day
        postData += "&" + googleFormHourField + "=" + hour
        postData += "&" + googleFormMinuteField + "=" + minute
        postData += "&" + googleFormEstablishmentField + "=" + establishment
        postData += "&" + googleFormZHMeatProcessorsField + "=" + zHProcessors
        postData += "&" + googleFormCrescentField + "=" + crescent
        postData += "&" + googleFormHalalFarmsField + "=" + halalFarms
        postData += "&" + googleFormHibaTradersField + "=" + hibaTraders
        postData += "&" + googleFormMiscellaneousField + "=" + miscellaneous
        postData += "&" + googleFormNotesField + "=" + notes
        
        self.upload_request(postData: postData)
    }

    func upload_request(postData: String) {
        
        let url = NSURL(string: googleFormLink)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringCacheData
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData.data(using: String.Encoding.utf8)
        let task = session.dataTask(with: request as URLRequest) {
            ( data, response, error) in
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            print(data)
            print(response)
            
        }
        task.resume()
    }
    
    func postNotification(){
        let url = NSURL(string: googleFCMEndpoint)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
//        request.cachePolicy = .reloadIgnoringCacheData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(fcmAuthKey, forHTTPHeaderField: "Authorization")
        
        
//        {
//            "notification": {
//                "title": "File Uploaded",
//                "text": "IDOF Belmont from Sameer Siddiqui"
//            },
//            "project_id": "halal-advocates-inspection",
//            "to":"/topics/Chicago"
//        }
        
        let dict: NSDictionary = ["notification":["title":"File Uploaded","text":"\(HIManager.sharedClient().currentEstablishment) from \(HIManager().userName)"],"project_id":"halal-advocates-inspection","to":"/topics/\(HIManager().currentChapter)"]
        do {
        let dat = try JSONSerialization.data(withJSONObject: dict, options:JSONSerialization.WritingOptions(rawValue: UInt(0)))
            request.httpBody = dat

        }
        catch let error as NSError {
            print (error.localizedDescription)
        }

        let task = session.dataTask(with: request as URLRequest) {
            ( data, response, error) in
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            print(data)
            print(response)
            
        }
        task.resume()

    }

    func parseJSON(_ data: Data) -> [String: AnyObject]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject]
            return json
        }
        catch let error as NSError {
            print("A JSON parsing error occurred, here are the details:\n \(error)")
        }
        
        return nil
    }
    

     struct HTTPHelper {
         init() {
        }
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
