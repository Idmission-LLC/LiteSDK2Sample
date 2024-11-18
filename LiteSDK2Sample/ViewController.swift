//
//  ViewController.swift
//  LiteSDK2Sample
//
//  Created by Amol Deshmukh on 29/04/22.
//

import UIKit
import IDentityLiteSDK

class ViewController: UIViewController, UITextFieldDelegate {
    
    //Token Generation TextField
    @IBOutlet var authUrl_Textfield : UITextField!
    @IBOutlet var loginID_Textfield : UITextField!
    @IBOutlet var password_Textfield : UITextField!
    @IBOutlet var merchantID_Textfield : UITextField!
    @IBOutlet var clientID_Textfield : UITextField!
    @IBOutlet var clientSecret_Textfield : UITextField!
    
    //SDK Initialization TextField
    @IBOutlet var apiBaseURL_Textfield : UITextField!
    @IBOutlet var token_Textfield : UITextField!
    
    @IBOutlet var activityIndicator : UIActivityIndicatorView!
    @IBOutlet var sdkVersion_Label : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sdkVersion_Label.text = "SDK Version : " + IDentitySDK.version
    }
    
    override func viewWillAppear(_ animated: Bool) {
        token_Textfield.text = ""
    }
    
    //Initialize SDK
    @IBAction func generateAccessTokenTapped(_ sender:Any) {
        generateAccessToken()
    }

    //Initialize SDK
    @IBAction func initializeSDKTapped(_ sender:Any) {
        SDKInitializationAPICall()
    }
    
}

//MARK: - SDK Initialization Method
extension ViewController {
        
    func SDKInitializationAPICall() {
        
        guard let apiBaseUrl = apiBaseURL_Textfield.text, apiBaseUrl != "" else {
            displayAlert(title: "", Message: "Please enter valid ApiBaseUrl.")
            return
        }
        guard let generatedToken = token_Textfield.text, apiBaseUrl != "" else {
            displayAlert(title: "", Message: "Please enter valid token.")
            return
        }

        self.activityIndicator.startAnimating()

        //1. Customize SDK properties
        SDKCustomization()
        
        //2. initialize SDK
        IDentitySDK.apiBaseUrl = apiBaseUrl
        IDentitySDK.initializeSDK(accessToken: generatedToken) { error in
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
    
    func SDKCustomization() {
        
        //IDCapture Customization
        IDCapture.options.frontRealnessThreshold = 0.5
        IDCapture.options.backRealnessThreshold = 0.3
        IDCapture.options.frontDocumentConfidence = 0.7
        IDCapture.options.backDocumentConfidence = 0.7
        IDCapture.options.lowerWidthThresholdTolerance = 0.4
        IDCapture.options.upperWidthThresholdTolerance = 0.1
        IDCapture.options.isDebugMode = false
        IDCapture.options.enableInstructionScreen = true
        IDCapture.options.enableRealId = false
        IDCapture.options.uploadIdData = true
        IDCapture.options.capture4K = true

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
//        IDCapture.images.frontSilhouetteImage = UIImage(named: "IdFrontOverlay")
//        IDCapture.images.backSilhouetteImage = UIImage(named: "IdBackOverlay")
//        IDCapture.images.retryScreenImage = UIImage(named: "IdRetryImage")
        
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

        //SelfieCapture Camera Screen Customization
        SelfieCapture.strings.alignOval = "Align your face inside oval"
        SelfieCapture.strings.moveAway = "Move ID Away"
        SelfieCapture.strings.moveCloser = "Move ID Closer"
        SelfieCapture.strings.leftEyeClosed = "Left eye are closed"
        SelfieCapture.strings.rightEyeClosed = "right eye are closed"
        SelfieCapture.strings.faceMaskDetected = "Face mask detected"
        SelfieCapture.strings.sunglassesDetected = "Glasses Detected"
        SelfieCapture.strings.removeHat = "hat Detected"
        SelfieCapture.strings.fakeFace = "Fake face Detected"
        SelfieCapture.strings.realFace = "real face Detected"
        SelfieCapture.strings.straightenHead = "Make Sure your head is straight"
        SelfieCapture.strings.moveFaceDown = "Move face Down"
        SelfieCapture.strings.moveFaceUp = "Move face Up"
        SelfieCapture.strings.moveFaceDown = "Move face Down"
        SelfieCapture.strings.capturingFace = "Capturing Face"
        SelfieCapture.strings.tooMuchLight = "Too much light around face"
        SelfieCapture.colors.backgroundColor = .clear
        SelfieCapture.colors.successLabelBackgroundColor = .green
        SelfieCapture.colors.errorLabelBackgroundColor = .red
        SelfieCapture.colors.successLabelTextColor = .white
        SelfieCapture.colors.errorLabelTextColor = .white
        SelfieCapture.fonts.labelFont = UIFont.systemFont(ofSize: 14)
//        SelfieCapture.images.silhouetteImage = UIImage(named: "Selfiecapture")
//        SelfieCapture.images.retryScreenImage = UIImage(named: "SelfieRetryImage")

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

    func displayAlert(title : String, Message:String){
        let alert = UIAlertController(title: title, message: Message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

//MARK: - UITextfield Delegate Method
extension ViewController {
    
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
