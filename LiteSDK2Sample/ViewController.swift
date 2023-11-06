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
    @IBOutlet var sdkVersion_Label : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sdkVersion_Label.text = "SDK Version : " + IDentitySDK.version
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
        
        //SDK Customization method
        SDKCustomization()
        
        //SDKInitialization method
        SDKInitializationAPICall(templateModelURL: templateModelURL, baseAPIURLURL: baseAPIURLURL, theLoginID: theLoginID, thePassword: thePassword, theMerchantID: theMerchantID)

    }
    
    func SDKCustomization() {
        
        //IDCapture Customization
        IDCapture.options.frontRealnessThreshold = 0.5
        IDCapture.options.backRealnessThreshold = 0.3
        IDCapture.options.frontDocumentConfidence = 0.7
        IDCapture.options.backDocumentConfidence = 0.7
        IDCapture.options.documentComponentConfidence = 0.5
        IDCapture.options.lowerWidthThresholdTolerance = 0.4
        IDCapture.options.upperWidthThresholdTolerance = 0.1
        IDCapture.options.isDebugMode = false
        IDCapture.options.enableInstructionScreen = true
        IDCapture.options.enableRealId = true
        IDCapture.options.uploadIdData = true
        IDCapture.options.capture4K = true

        //IDCapture Camera Screen UI Customization
        IDCapture.strings.closeButtonText = "Cancel"
        IDCapture.strings.captureFront = "Capture Front Side"
        IDCapture.strings.captureBack = "Capture Back Side"
        IDCapture.strings.moveAway = "Move ID Away"
        IDCapture.strings.moveCloser = "Move ID Closer"
        IDCapture.strings.makeSurePhotoTextVisible = "Make Sure Photo & Text are Visible in ID"
        IDCapture.strings.makeSureBarcodeVisible = "Make sure Barcode is visible"
        IDCapture.strings.alignRectangle = "Align ID inside Rectangle"
        IDCapture.strings.flipToBack = "Flip To Back side"
        IDCapture.strings.tooMuchGlare = "Too Much Glare"
        IDCapture.colors.overlayTopViewColor = .clear
        IDCapture.colors.closeButtonTextColor = .white
        IDCapture.colors.closeButtonColor = .clear
        IDCapture.colors.closeButtonImageTintColor = .white
        IDCapture.colors.successLabelBackgroundColor = .green
        IDCapture.colors.errorLabelBackgroundColor = .red
        IDCapture.colors.successLabelTextColor = .white
        IDCapture.colors.captureLabelColor = .clear
        IDCapture.colors.captureLabelTextColor = .white
        IDCapture.colors.errorLabelTextColor = .white
        IDCapture.colors.backgroundColor = .clear
        IDCapture.fonts.closeButtonTextFont = UIFont.systemFont(ofSize: 20)
        IDCapture.fonts.captureLabelFont = UIFont.boldSystemFont(ofSize: 14)
        IDCapture.fonts.labelFont = UIFont.systemFont(ofSize: 14)
        IDCapture.layout.labelPosition = .top
//        IDCapture.images.closeButtonImage = UIImage(named: "Close")
//        IDCapture.images.silhouetteImage = UIImage(named: "IdOverlay")
//        IDCapture.images.frontSilhouetteImage = UIImage(named: "IdFrontOverlay")
//        IDCapture.images.backSilhouetteImage = UIImage(named: "IdBackOverlay")
//        IDCapture.images.bottomInfoImage = UIImage(named: "IdiInfo")

        //IDCapture Instruction Screen UI Customization
        IDCapture.strings.instructionScreenText = "Lorem ipsum text"
        IDCapture.strings.instructionScreenButtonText = "Continue"
        IDCapture.colors.instructionScreenBackgroundColor = .white
        IDCapture.colors.instructionScreenImageTintColor = .white
        IDCapture.colors.instructionScreenLabelTextColor = .black
        IDCapture.colors.instructionScreenButtonTextColor = .white
        IDCapture.colors.instructionScreenButtonBackgroundColor = .gray
        IDCapture.fonts.instructionScreenLabelFont = UIFont.systemFont(ofSize: 20)
        IDCapture.fonts.instructionScreenButtonFont = UIFont.systemFont(ofSize: 20)
//        IDCapture.images.instructionScreenImage = UIImage(named: "IDCaptureImage")

        //IDCapture Retry Screen UI Customization
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
//        IDCapture.images.retryScreenImage = UIImage(named: "IdRetryImage")

        //SelfieCapture Customization
        SelfieCapture.options.minFaceWidth = 0.6
        SelfieCapture.options.eyeOpenProbability = 0.4
        SelfieCapture.options.minHeadEulerAngle = -10
        SelfieCapture.options.maxHeadEulerAngle = 10
        SelfieCapture.options.minRelativeNoseHeight = 0.48
        SelfieCapture.options.maxRelativeNoseHeight = 0.67
        SelfieCapture.options.labelsConfidenceThreshold = 0.79
        SelfieCapture.options.faceMaskProbabilityThreshold = 0.79
        SelfieCapture.options.liveFaceProbabilityThreshold = 0.9
        SelfieCapture.options.consecutiveFakeFaceLimit = 10
        SelfieCapture.options.lightIntensityThreshold = 0.05
        SelfieCapture.options.isDebugMode = false
        SelfieCapture.options.enableInstructionScreen = true
        SelfieCapture.options.capture4K = false
        SelfieCapture.options.uploadFaceData = true

        //SelfieCapture Camera Screen UI Customization
        SelfieCapture.strings.closeButtonText = "Cancel"
        SelfieCapture.strings.alignOval = "Align your face inside oval"
        SelfieCapture.strings.moveAway = "Move Face Away"
        SelfieCapture.strings.moveCloser = "Move Face Closer"
        SelfieCapture.strings.leftEyeClosed = "Left eye are closed"
        SelfieCapture.strings.rightEyeClosed = "right eye are closed"
        SelfieCapture.strings.faceMaskDetected = "Face mask detected"
        SelfieCapture.strings.sunglassesDetected = "Glasses Detected"
        SelfieCapture.strings.removeHat = "Hat Detected"
        SelfieCapture.strings.fakeFace = "Fake face Detected"
        SelfieCapture.strings.realFace = "Real face Detected"
        SelfieCapture.strings.straightenHead = "Make Sure your head is straight"
        SelfieCapture.strings.moveFaceDown = "Move face Down"
        SelfieCapture.strings.moveFaceUp = "Move face Up"
        SelfieCapture.strings.moveFaceDown = "Move face Down"
        SelfieCapture.strings.capturingFace = "Capturing Face"
        SelfieCapture.strings.tooMuchLight = "Too much light around face"
        SelfieCapture.colors.backgroundColor = .clear
        SelfieCapture.colors.overlayTopViewColor = .clear
        SelfieCapture.colors.closeButtonTextColor = .white
        SelfieCapture.colors.closeButtonColor = .clear
        SelfieCapture.colors.closeButtonImageTintColor = .white
        SelfieCapture.colors.successLabelBackgroundColor = .green
        SelfieCapture.colors.errorLabelBackgroundColor = .red
        SelfieCapture.colors.successLabelTextColor = .white
        SelfieCapture.colors.errorLabelTextColor = .white
        SelfieCapture.fonts.labelFont = UIFont.systemFont(ofSize: 20)
        SelfieCapture.fonts.closeButtonTextFont = UIFont.systemFont(ofSize: 20)
        SelfieCapture.layout.labelPosition = .top
//        SelfieCapture.images.closeButtonImage = UIImage(named: "Close")
//        SelfieCapture.images.silhouetteImage = UIImage(named: "SelfieOverlay")
//        SelfieCapture.images.bottomInfoImage = UIImage(named: "Selfieinfo")

        //SelfieCapture Instruction Screen UI Customization
        SelfieCapture.strings.instructionScreenText = "Lorem ipsum text"
        SelfieCapture.strings.instructionScreenButtonText = "Continue"
        SelfieCapture.colors.instructionScreenBackgroundColor = .white
        SelfieCapture.colors.instructionScreenImageTintColor = .white
        SelfieCapture.colors.instructionScreenLabelTextColor = .black
        SelfieCapture.colors.instructionScreenButtonTextColor = .white
        SelfieCapture.colors.instructionScreenButtonBackgroundColor = .gray
        SelfieCapture.fonts.instructionScreenLabelFont = UIFont.systemFont(ofSize: 20)
        SelfieCapture.fonts.instructionScreenButtonFont = UIFont.systemFont(ofSize: 20)
//        SelfieCapture.images.instructionScreenImage = UIImage(named: "SelfieCaptureImage")

        //SelfieCapture Retry Screen UI Customization
        SelfieCapture.strings.retryScreenText = "Live face not Detected. Please try again"
        SelfieCapture.strings.retryButtonText = "Retry"
        SelfieCapture.strings.cancelButtonText = "Cancel"
        SelfieCapture.colors.retryScreenBackgroundColor = .white
        SelfieCapture.colors.retryScreenLabelTextColor = .black
        SelfieCapture.colors.retryScreenImageTintColor = .blue
        SelfieCapture.colors.retryScreenButtonTextColor = .blue
        SelfieCapture.colors.retryScreenButtonBackgroundColor = .clear
        SelfieCapture.fonts.retryScreenLabelFont = UIFont.systemFont(ofSize: 20)
        SelfieCapture.fonts.retryScreenButtonFont = UIFont.systemFont(ofSize: 20)
//        SelfieCapture.images.retryScreenImage = UIImage(named: "SelfieRetryImage")

    }

    func SDKInitializationAPICall(templateModelURL:String, baseAPIURLURL:String, theLoginID:String, thePassword:String, theMerchantID:String) {
        
        self.activityIndicator.startAnimating()

        IDentitySDK.initializeApiBaseUrl = templateModelURL
        IDentitySDK.apiBaseUrl = baseAPIURLURL
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
