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
        
        //UICustomization method
        SDKUICustomization()
        
        //SDKInitialization method
        SDKInitializationAPICall(templateModelURL: templateModelURL, baseAPIURLURL: baseAPIURLURL, theLoginID: theLoginID, thePassword: thePassword, theMerchantID: theMerchantID)

    }
    
    func SDKUICustomization() {
        
        //IDCapture Camera Screen Customization
        IDCapture.strings.captureFront = "Capture Front Side"
        IDCapture.strings.captureBack = "Capture Back Side"
        IDCapture.strings.moveAway = "Move ID Away"
        IDCapture.strings.moveCloser = "Move ID Closer"
        IDCapture.strings.makeSurePhotoTextVisible = "Make Sure Photo & Text are Visible in ID"
        IDCapture.strings.makeSureBarcodeVisible = "Make sure Barcode is visible"
        IDCapture.strings.alignRectangle = "Align ID inside Rectangle"
        IDCapture.strings.flipToBack = "Flip To Back side"
        IDCapture.strings.tooMuchGlare = "Too Much Glare"
        IDCapture.colors.successLabelBackgroundColor = .green
        IDCapture.colors.errorLabelBackgroundColor = .red
        IDCapture.colors.successLabelTextColor = .white
        IDCapture.colors.errorLabelTextColor = .white
        IDCapture.colors.backgroundColor = .clear
        IDCapture.fonts.captureLabelFont = UIFont.boldSystemFont(ofSize: 14)
        IDCapture.fonts.labelFont = UIFont.systemFont(ofSize: 14)
        
        //IDCapture Retry Screen Customization
        IDCapture.strings.retryScreenText = "RealID not Detected. Please try again"
        IDCapture.strings.retryButtonText = "Retry"
        IDCapture.strings.cancelButtonText = "Cancel"
        IDCapture.colors.retryScreenBackgroundColor = .white
        IDCapture.colors.retryScreenLabelTextColor = .black
        IDCapture.colors.retryScreenImageTintColor = .green
        IDCapture.colors.retryScreenButtonTextColor = .green
        IDCapture.colors.retryScreenButtonBackgroundColor = .clear
        IDCapture.fonts.retryScreenLabelFont = UIFont.systemFont(ofSize: 16)
        IDCapture.fonts.retryScreenButtonFont = UIFont.systemFont(ofSize: 14)

        
        //SelfieCapture Camera Screen Customization
        SelfieCapture.strings.alignOval = "Aligh your face inside oval"
        SelfieCapture.strings.moveAway = "Move ID Away"
        SelfieCapture.strings.moveCloser = "Move ID Closer"
        SelfieCapture.strings.leftEyeClosed = "Left eye are closed"
        SelfieCapture.strings.rightEyeClosed = "right eye are closed"
        SelfieCapture.strings.faceMaskDetected = "Face mask detected"
        SelfieCapture.strings.glassesDetected = "Glasses Detected"
        SelfieCapture.strings.removeHat = "hat Detected"
        SelfieCapture.strings.fakeFace = "Fake face Detected"
        SelfieCapture.strings.realFace = "real face Detected"
        SelfieCapture.strings.straightenHead = "Make Sure your head is straight"
        SelfieCapture.strings.moveFaceDown = "Move face Down"
        SelfieCapture.strings.moveFaceUp = "Move face Up"
        SelfieCapture.strings.moveFaceDown = "Move face Down"
        SelfieCapture.strings.capturingFace = "Capturing Face"
        SelfieCapture.strings.tooMuchLight = "Too much light around face"
        SelfieCapture.colors.backgroundColor = .white
        SelfieCapture.colors.successLabelBackgroundColor = .green
        SelfieCapture.colors.errorLabelBackgroundColor = .red
        SelfieCapture.colors.successLabelTextColor = .white
        SelfieCapture.colors.errorLabelTextColor = .white
        SelfieCapture.fonts.labelFont = UIFont.systemFont(ofSize: 14)

        //SelfieCapture Retry Screen Customization
        SelfieCapture.strings.retryScreenText = "Live face not Detected. Please try again"
        SelfieCapture.strings.retryButtonText = "Retry"
        SelfieCapture.strings.cancelButtonText = "Cancel"
        SelfieCapture.colors.retryScreenBackgroundColor = .white
        SelfieCapture.colors.retryScreenLabelTextColor = .black
        SelfieCapture.colors.retryScreenImageTintColor = .blue
        SelfieCapture.colors.retryScreenButtonTextColor = .blue
        SelfieCapture.colors.retryScreenButtonBackgroundColor = .clear
        SelfieCapture.fonts.retryScreenLabelFont = UIFont.systemFont(ofSize: 16)
        SelfieCapture.fonts.retryScreenButtonFont = UIFont.systemFont(ofSize: 14)

    }
    
    func SDKInitializationAPICall(templateModelURL:String, baseAPIURLURL:String, theLoginID:String, thePassword:String, theMerchantID:String) {
        
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
