//
//  FormTableViewController.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/31/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import PDFGenerator
import Firebase
class FormTableViewController: UITableViewController, UITextViewDelegate {
    
    fileprivate let HImanager = HIManager.sharedClient()

    static func create() -> FormTableViewController {
        let frameworkBundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewController(withIdentifier: "FormTableViewController") as! FormTableViewController
        return main
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.HIBackground
        self.setNavBarWithBackButton()
        self.hideKeyboardWhenTappedAround()
    }

    override func backButtonPressed() {
        _ = self.navigationController?.popViewController(animated: true)
        HImanager.supplierValues = []
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        HImanager.comments = textView.text
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HImanager.supplierArray.count + 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell", for: indexPath) as! NameTableViewCell
            cell.configureNameCell()
            return cell
        }
        if indexPath.row > 0 && indexPath.row <= HImanager.supplierArray.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SupplierTableViewCell", for: indexPath) as! SupplierTableViewCell
            cell.configureSupplierCell(indexPath.row-1)
            return cell
        }
        if indexPath.row == HImanager.supplierArray.count+1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
            cell.configureCommentTableViewCell()
            cell.textView.delegate = self
            return cell
        }
        if indexPath.row == HImanager.supplierArray.count+2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitTableViewCell", for: indexPath) as! SubmitTableViewCell
            cell.configureCell()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 4{
//            self.generatePDF()
//        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //MARK: - PDF 
 
    func generatePDF() {
        let v1 = UIView(frame: CGRect(x: 0.0,y: 0, width: 516, height: 729))

        let banner = UIImageView(frame: CGRect(x: 10, y: 10, width: 200, height: 140))
        banner.image = UIImage(named:"haa-logo")
        banner.contentMode = .scaleAspectFit
        v1.addSubview(banner)
        
        let info = UILabel(frame:CGRect(x: 516-160, y: 10, width: 150, height: 150))
        info.text = "\(HImanager.currentDate)\n\(HImanager.userName)\n\(HImanager.currentChapter)\n\(HImanager.currentEstablishment)"
        info.font = UIFont(name: "AvenirNext-Medium", size: 14)
        info.numberOfLines = 5
        info.textAlignment = .right
        v1.addSubview(info)
        
        let imageInfo = UILabel(frame:CGRect(x: 516/2 - 200, y: 709, width: 400, height: 20))
        imageInfo.text = "Images on subsequent pages"
        imageInfo.font = UIFont(name: "AvenirNext-Medium", size: 14)
        imageInfo.textAlignment = .center
        v1.addSubview(imageInfo)
        
        let inspect = UILabel(frame:CGRect(x: 10, y: 165, width: 400, height: 20))
        inspect.text = "Inspection Notes:"
        inspect.font = UIFont(name: "AvenirNext-Bold", size: 16)
        v1.addSubview(inspect)
        
        for i in 0..<HImanager.supplierValues.count {
            let supplierInfo = UILabel(frame:CGRect(x: 10, y: 190 + (i*20), width: 400, height:20))
            let supplier: NSDictionary = HImanager.supplierValues.object(at: i) as! NSDictionary
            let key = supplier.allKeys[0] as! String
            let value = supplier.allValues[0] as! String
            supplierInfo.text = "\(key) : \(value)"
            supplierInfo.font = UIFont(name: "AvenirNext-Medium", size: 14)
            v1.addSubview(supplierInfo)
        }
        
        let comments = UILabel(frame:CGRect(x: 10, y: 210 + (HImanager.supplierValues.count*20), width: 490, height: 100))
        comments.text = "Comments and Concerns : \n\(HImanager.comments)"
        comments.font = UIFont(name: "AvenirNext-Medium", size: 14)
        comments.numberOfLines = 6
        v1.addSubview(comments)
        
        let page1 = PDFPage.view(v1)
        
        var pages = [page1]
        for image in HIManager.sharedClient().images {
            
            let view = UIView(frame: CGRect(x: 0,y: 0, width: 516, height: 729))
            let imageView = UIImageView(frame:CGRect(x: 0,y: 0, width: 516, height: 729))
            imageView.image = image as? UIImage
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            let page = PDFPage.view(view)
            pages.append(page)
        }
        
        let trimmedChapter = (HIManager().currentChapter as NSString).replacingOccurrences(of: " ", with: "_")
        let trimmedEstablishment = (HIManager().currentEstablishment as NSString).replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: ".", with: "_")
        let trimmedUserName = (HIManager().userName as NSString).replacingOccurrences(of: " ", with: "_")
        let pdfname = "\(trimmedChapter)_\(trimmedEstablishment)_\(trimmedUserName).pdf"
        
        let dst = URL(fileURLWithPath: NSTemporaryDirectory().appending(pdfname))
        // outputs as Data
        do {
            let data = try PDFGenerator.generated(by: pages)
            try data.write(to: dst, options: .atomic)
        } catch (let error) {
            print(error)
        }
        
        
//        let zh = (HIManager.sharedClient().supplierArray[0] )
        
        WebService().sendToGoogleForms(name: "Junaid", year: "2016", month: "09", day: "29", hour: "10", minute: "05", establishment: "BBQ Tonight", zHProcessors: "22", crescent: "33", halalFarms: "44", hibaTraders: "55", miscellaneous: "55", notes: "testing")
        
        
        
        
        
        let storage = FIRStorage.storage()

        // File located on disk
        let storageRef = storage.reference()

        // Create a reference to the file you want to upload
        let pdfRef = storageRef.child("\(HImanager.currentChapter)/\(pdfname)")
        
        let uploadTask = pdfRef.putFile(dst, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy_hh_mm_ss"
                let dateString: NSString = dateFormatter.string(from: date) as NSString
        
                let dict: NSDictionary = [dateString:(metadata!.name)!]
                let ref: FIRDatabaseReference =  FIRDatabase.database().reference()
                ref.child("metadata").child(self.HImanager.currentChapter).childByAutoId().setValue(dict, withCompletionBlock: { (error, databaseref) in
                
                })
                print(metadata?.path)
            }
        }
        uploadTask.resume()

    }
    
}
