//
//  ViewController.swift
//  LiteSDK2Sample
//
//  Created by Amol Deshmukh on 29/04/22.
//

import UIKit
import IDentityLiteSDK

class ViewController: UIViewController {

    @IBOutlet var templateURL_Textfield : UITextField!
    @IBOutlet var apiBaseURL_Textfield : UITextField!
    @IBOutlet var loginID_Textfield : UITextField!
    @IBOutlet var password_Textfield : UITextField!
    @IBOutlet var merchantID_Textfield : UITextField!
    @IBOutlet var activityIndicator : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Initialize SDK
    @IBAction func initializeSDK(_ sender:Any) {
        
        //Validate the input data
        guard let templateModelURL = templateURL_Textfield.text , !templateModelURL.isEmpty, !templateModelURL.trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") else{
                //Show alert
            self.displayAlert(title: "URL Can't Be Empty", Message: "")
            return
        }
        
        guard let baseAPIURLURL = apiBaseURL_Textfield.text , !baseAPIURLURL.isEmpty, !baseAPIURLURL.trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") else{
                //Show alert
            self.displayAlert(title: "URL Can't Be Empty", Message: "")
            return
        }
        
        guard let theLoginID = loginID_Textfield.text , !theLoginID.isEmpty, !theLoginID.trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") else{
                //Show alert
            self.displayAlert(title: "LoginID Can't Be Empty", Message: "")
            return
        }
        
        guard let thePassword = password_Textfield.text , !thePassword.isEmpty, !thePassword.trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") else{
                //Show alert
            self.displayAlert(title: "Password Can't Be Empty", Message: "")
            return
        }
        
        guard let theMerchantID = merchantID_Textfield.text , !theMerchantID.isEmpty, !theMerchantID.trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") else{
                //Show alert
            self.displayAlert(title: "MerchantID Can't Be Empty", Message: "")
            return
        }
        
        self.activityIndicator.startAnimating()

        IDentitySDK.templateModelBaseURL = templateModelURL
        IDentitySDK.apiBaseURL = baseAPIURLURL

        IDentitySDK.initializeSDK(loginId: theLoginID, password: thePassword, merchantId: theMerchantID) { error in
            self.activityIndicator.stopAnimating()
            if let error = error {
                print("!!! initialize SDK ERROR: \(error.localizedDescription)")
                self.displayAlert(title: "Error", Message: "SDK initialization credentials are not correct")
            } else {
                print("!!! initialize SDK SUCCESS")
                self.performSegue(withIdentifier: "CompleteKYC_SegueID", sender: nil)
            }
        }

    }
    
    func displayAlert(title : String, Message:String){
        let alert = UIAlertController(title: title, message: Message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
