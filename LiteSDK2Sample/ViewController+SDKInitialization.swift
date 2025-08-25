//
//  ViewController+SDKInitialization.swift
//  LiteSDK2Sample
//
//  Created by Amol Deshmukh on 25/02/25.
//

import IDentityLiteSDK
import IDCaptureLite
import SelfieCaptureLite

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
        IDentitySDK.delegate = self
        IDentitySDK.apiBaseUrl = apiBaseUrl
        IDentitySDK.initializeSDK(accessToken: generatedToken) { error in
            if let error = error {
                self.activityIndicator.stopAnimating()
                print("!!! initialize SDK ERROR: \(error.localizedDescription)")
                self.displayAlert(title: "Error", Message: "SDK initialization credentials are not correct")
            } else {
                print("!!! initialize SDK SUCCESS")
//                self.performSegue(withIdentifier: "CompleteKYC_SegueID", sender: nil)
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

extension ViewController: InitializationDelegate {
    func updateInitialization(stage: IDentityLiteSDK.InitializationStage, state: IDentityLiteSDK.InitializationState) {
        
        //1. Debug-Purpose : Just to print information in logs
        let stage_state_Value = "\(stage.rawValue) \(state.rawValue)"
        switch stage {
        case .login: print("Login Status :", stage_state_Value)
        case .getXsltData: print("XSLT Download Status :", stage_state_Value)
        case .searchCompanyTemplateDetails: print("Template Download Status :", stage_state_Value)
        case .passiveFaceTrainingModelLabel: print("FaceModel Download Status :", stage_state_Value)
        case .focusFaceTrainingModelLabel: print("FaceFocusModel Download Status :", stage_state_Value)
        case .docDetectionTrainingModelLabel: print("DocDetectModel Download Status :", stage_state_Value)
        case .fingerprintDetectionTrainingModelLabel: print("FingerPrintModel Download Status :", stage_state_Value)
        case .focusTrainingModelLabel: print("IDFocusModel Download Status :", stage_state_Value)
        @unknown default: print("Unknown Status :", stage_state_Value)
        }
        
        //2. check for completion of the stage states
        states[stage] = state
        if states[.login] == .downloaded &&
            ([.ok, .downloaded].contains(states[.getXsltData])) &&
            ([.ok, .downloaded].contains(states[.searchCompanyTemplateDetails])) &&
            ([.ok, .downloadedFromS3].contains(states[.passiveFaceTrainingModelLabel])) &&
            ([.ok, .downloadedFromS3].contains(states[.focusFaceTrainingModelLabel])) &&
            ([.ok, .downloadedFromS3].contains(states[.docDetectionTrainingModelLabel])) &&
            ([.ok, .downloadedFromS3].contains(states[.fingerprintDetectionTrainingModelLabel])) &&
            ([.ok, .downloadedFromS3].contains(states[.focusTrainingModelLabel])) {
            
            activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "CompleteKYC_SegueID", sender: nil)
            
        } else if states[.login] == .error || states[.getXsltData] == .error || states[.searchCompanyTemplateDetails] == .error  {
            
            print("!!! initialize SDK ERROR ")
            activityIndicator.stopAnimating()
            self.displayAlert(title: "Error", Message: "SDK initialization Error")
            
        }
    }
}

extension ViewController {
    
    func SDKCustomization() {
        
        //IDCapture Customization
        IDCapture.options.frontRealnessThreshold = 0.5
        IDCapture.options.backRealnessThreshold = 0.3
        IDCapture.options.frontDocumentConfidence = 0.7
        IDCapture.options.backDocumentConfidence = 0.7
        IDCapture.options.lowerWidthThresholdTolerance = 0.2
        IDCapture.options.upperWidthThresholdTolerance = 0.05
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
}
