//
//  ResultScreenFor50.swift
//  IdentityLite 2.0
//
//  Created by daffolapmac-190 on 02/11/21.
//

import UIKit
import IDentityLiteSDK
import IDCaptureLite
import SelfieCaptureLite

protocol ResultScreenFor50Delegate{
    func doneButtonPressed()
}

class ResultScreenFor50: UIView {
    
    public var delegate : ResultScreenFor50Delegate?
    
    //CapturedResult
    @IBOutlet weak var capturedResultLabel: UILabel!
    @IBOutlet weak var capturedResultLabel_HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var capturedResultLabel_TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var capturedResultLabel_BottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var capturedResultContainerView: UIView!
    @IBOutlet weak var capturedResultContainerView_HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var capturedResultSelfieImageView: UIImageView!
    @IBOutlet weak var capturedResultSelfieImageStatusIV: UIImageView!
    @IBOutlet weak var capturedResultSelfieMatchConfidenceLabel: UILabel!
    @IBOutlet weak var capturedResultIdFrontImage: UIImageView!
    @IBOutlet weak var capturedResultIdBackImage: UIImageView!
    
    //ProcessedResult
    @IBOutlet weak var processedResultHeadingLabel: UILabel!
    @IBOutlet weak var processedResultActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var processedResultLabel: UILabel!
    
    @IBOutlet weak var processedResultContainerView: UIView! //843
    @IBOutlet weak var processedResultContainerView_HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var processedResultFullNameLabel: UILabel!
    @IBOutlet weak var processedResultDateOfBirthLabel: UILabel!
    @IBOutlet weak var processedResultDocumentNumberLabel: UILabel!
    @IBOutlet weak var processedResultIdTypeLabel: UILabel!
    @IBOutlet weak var processedResultIdIssueDateLabel: UILabel!
    @IBOutlet weak var processedResultIdExpiryDateLabel: UILabel!
    @IBOutlet weak var processedResultAdressLabel: UILabel!
    @IBOutlet weak var processedResultSexLabel: UILabel!
    @IBOutlet weak var processedResultIdImageView_SatckView: UIStackView!
    @IBOutlet weak var processedResultIdFrontImageView: UIImageView!
    @IBOutlet weak var processedResultIdBackImageView: UIImageView!
    @IBOutlet weak var processedResultIdFrontImageView_HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var processedResultIdBackImageView_HeightConstraint: NSLayoutConstraint!

    // DMV Element
    @IBOutlet weak var procResltDMV_SatckView: UIStackView!
    @IBOutlet weak var procResltDMV_SatckView_HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var procResltDMV_StatusIndicatorImageWidth: NSLayoutConstraint!
    @IBOutlet weak var procResltDMV_StatusImageView: UIImageView!
    @IBOutlet weak var procResltDMV_StatusLabel: UILabel!
    @IBOutlet weak var procResltDMV_TopSeparator_HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var procResltDMV_BottomSeparator_HeightConstraint: NSLayoutConstraint!

    // AML-KYC Element
    @IBOutlet weak var procResltAMLKYC_SatckView: UIStackView!
    @IBOutlet weak var procResltAMLKYC_SatckView_HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var procResltAMLKYC_SatckView_TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var procResltAMLKYC_SatckView_BottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var procResltAMLKYC_StatusIndicator_StackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var procResltAMLKYC_StatusIndicatorTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var procResltAMLKYC_StatusIndicatorHeight: NSLayoutConstraint!
    @IBOutlet weak var procResltAMLKYC_PEPIndicatorHeight: NSLayoutConstraint!
    @IBOutlet weak var procResltAMLKYC_WLIndicatorHeight: NSLayoutConstraint!
    @IBOutlet weak var procResltAMLKYC_NMIndicatorHeight: NSLayoutConstraint!
    @IBOutlet weak var procResltAMLKYC_CRIndicatorHeight: NSLayoutConstraint!
    @IBOutlet weak var procResltAMLKYC_SOIndicatorHeight: NSLayoutConstraint!
    @IBOutlet weak var procResltAMLKYC_StatusIndicatorBottomSpacing: NSLayoutConstraint!

    @IBOutlet weak var procResltAMLKYC_Status_SatckView: UIStackView!
    @IBOutlet weak var procResltAMLKYC_PEP_SatckView: UIStackView!
    @IBOutlet weak var procResltAMLKYC_WL_SatckView: UIStackView!
    @IBOutlet weak var procResltAMLKYC_NM_SatckView: UIStackView!
    @IBOutlet weak var procResltAMLKYC_CR_SatckView: UIStackView!
    @IBOutlet weak var procResltAMLKYC_SO_SatckView: UIStackView!
    
    @IBOutlet weak var procResltAMLKYC_StatusImageView: UIImageView!
    @IBOutlet weak var procResltAMLKYC_StatusLabel: UILabel!
    
    @IBOutlet weak var procResltAMLKYC_PEPImageView: UIImageView!
    @IBOutlet weak var procResltAMLKYC_WLImageView: UIImageView!
    @IBOutlet weak var procResltAMLKYC_NMImageView: UIImageView!
    @IBOutlet weak var procResltAMLKYC_CRImageView: UIImageView!
    @IBOutlet weak var procResltAMLKYC_SOImageView: UIImageView!
    
    @IBOutlet weak var procResltAMLKYC_PEPCountLabel: UILabel!
    @IBOutlet weak var procResltAMLKYC_WLCountLabel: UILabel!
    @IBOutlet weak var procResltAMLKYC_NMCountLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var processingTimerLabel: UILabel!
    
    //MARK: - Initialize UIView
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    private func loadViewFromNib(){
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    init(frame: CGRect, customerEnroll_Result : CustomerEnrollResult) {
        super.init(frame: frame)
        loadViewFromNib()
        
        //Do the initial setup, and populate this XIB with your custom data
        addDesignToUI()
        populateThisXibWithData(customerEnrollResult: customerEnroll_Result)
        self.submitAPI(customerEnroll_Result: customerEnroll_Result)
    }
    
    private func addDesignToUI(){
        doneButton.layer.cornerRadius = 6
        
        capturedResultContainerView.layer.cornerRadius = 6.0
        capturedResultContainerView.layer.shadowColor = UIColor.black.cgColor
        capturedResultContainerView.layer.shadowOpacity = 0.5
        capturedResultContainerView.layer.shadowOffset = .zero
        capturedResultContainerView.layer.shadowRadius = 1
        capturedResultSelfieImageView.layer.cornerRadius = 6
        
        processedResultContainerView.layer.cornerRadius = 6.0
        processedResultContainerView.layer.shadowColor = UIColor.black.cgColor
        processedResultContainerView.layer.shadowOpacity = 0.5
        processedResultContainerView.layer.shadowOffset = .zero
        processedResultContainerView.layer.shadowRadius = 1
        
        isHideTopView(ishide: false)
        
        processedResultContainerView_HeightConstraint.constant = 0
        processedResultIdFrontImageView.isHidden = true
        processedResultIdBackImageView.isHidden = true

        processingTimerLabel.isHidden = true
    }
    
    func isHideTopView(ishide:Bool) {
        
        capturedResultContainerView_HeightConstraint.constant = 662
        capturedResultIdFrontImage.isHidden = true
        capturedResultIdBackImage.isHidden = true

    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.delegate?.doneButtonPressed()
    }
    
}

// MARK: -  Load XIB From Local Extracted data
extension ResultScreenFor50 {
    
    private func populateThisXibWithData(customerEnrollResult: CustomerEnrollResult?){
        //1. Show Selfie Image
        self.capturedResultSelfieImageView.image = customerEnrollResult?.selfie.image
        
        //2. Populate Xib with MRZ / Barcode Data
        if let frontSideData = customerEnrollResult?.front, frontSideData.shouldHaveMrz {
            populateFromDataMRZ(customerEnroll_Result: customerEnrollResult)
        } else if let backSideData = customerEnrollResult?.back, backSideData.shouldHaveMrz {
            populateFromDataMRZ(customerEnroll_Result: customerEnrollResult)
        } else if let frontSideData = customerEnrollResult?.front, frontSideData.shouldHaveBarcode {
            populateFromDataBarcode(customerEnroll_Result: customerEnrollResult)
        } else if let backSideData = customerEnrollResult?.back, backSideData.shouldHaveBarcode {
            populateFromDataBarcode(customerEnroll_Result: customerEnrollResult)
        } else {
            populateFromDataBarcode(customerEnroll_Result: customerEnrollResult)
        }
    }
    
    private func populateFromDataMRZ(customerEnroll_Result : CustomerEnrollResult?){
                
        //1. Show Front Image
        if let frontImage = customerEnroll_Result?.front.image {
            capturedResultIdFrontImage.image = frontImage
            capturedResultIdFrontImage.isHidden = false
        }else{
            capturedResultContainerView_HeightConstraint.constant -= 200
        }
        
        //2. Show Back Image
        if let backImage = customerEnroll_Result?.back?.image {
            capturedResultIdBackImage.image = backImage
            capturedResultIdBackImage.isHidden = false
        }else{
            capturedResultContainerView_HeightConstraint.constant -= 230
        }
        
    }
    
    private func populateFromDataBarcode(customerEnroll_Result : CustomerEnrollResult?){
                
        if let frontImage = customerEnroll_Result?.front.image {
            capturedResultIdFrontImage.image = frontImage
            capturedResultIdFrontImage.isHidden = false
        }else{
            capturedResultContainerView_HeightConstraint.constant -= 200
        }
        
        if let backImage = customerEnroll_Result?.back?.image {
            capturedResultIdBackImage.image = backImage
            capturedResultIdBackImage.isHidden = false
        }else{
            capturedResultContainerView_HeightConstraint.constant -= 230
        }

        if self.capturedResultContainerView_HeightConstraint.constant > 926 {
            self.capturedResultContainerView_HeightConstraint.constant += 20
        }
    }
        
}

// MARK: -  Load XIB From Server Extracted Data
extension ResultScreenFor50{
    
    func submitAPI(customerEnroll_Result : CustomerEnrollResult?) {
        
        //Populate the Processed Result Data
        customerEnroll_Result?.submit { result, hostData in
            self.processedResultHeadingLabel.isHidden = false
            self.processedResultActivityIndicator.stopAnimating()
            self.processedResultActivityIndicator.isHidden = true
            
            switch result {
            case .success(let response):
                print("Response SID-50 : ", response)
                
                //1. Unhide the Processed Result Label
                self.processedResultLabel.isHidden = false
                self.processedResultLabel.text = response.resultData?.verificationResult
                
                //2. Unhide the Processed Result Section
                self.processedResultContainerView.isHidden = false
                self.processedResultContainerView_HeightConstraint.constant = 988
                
                //3. Show ID-Selfie Match Tick-Image
                self.capturedResultSelfieMatchConfidenceLabel.isHidden = false
                if response.resultData?.faceVerificationResult == "Verified" {
                    self.capturedResultSelfieImageStatusIV.image = UIImage(named: "icon_photo_match")
                }else{
                    self.capturedResultSelfieImageStatusIV.image = UIImage(named: "icon_photo_not_match")
                }

                //4. Show Full Name, DOB, DocumentNo, ExpiryDate, Address, Gender
                if let name = response.responseCustomerData?.extractedPersonalData?.name, name != "" {
                    self.processedResultFullNameLabel.text = name
                }
                if let dob = response.responseCustomerData?.extractedPersonalData?.dob, dob != "" {
                    self.processedResultDateOfBirthLabel.text = dob
                }
                if let idNumber = response.responseCustomerData?.extractedIdData?.idNumber, idNumber != "" {
                    self.processedResultDocumentNumberLabel.text = idNumber
                }
                if let idIssueDate = response.responseCustomerData?.extractedIdData?.idIssueDate, idIssueDate != "" {
                    self.processedResultIdIssueDateLabel.text = idIssueDate
                }
                if let idExpirationDate = response.responseCustomerData?.extractedIdData?.idExpirationDate, idExpirationDate != "" {
                    self.processedResultIdExpiryDateLabel.text = idExpirationDate
                }
                if let idType = response.responseCustomerData?.extractedIdData?.idType, idType != "" {
                    self.processedResultIdTypeLabel.text = idType
                }
                if let address = self.getAddressFromResponse(response: response), address != "" {
                    self.processedResultAdressLabel.text = address
                }
                if let gender = response.responseCustomerData?.extractedPersonalData?.gender, gender != "" {
                    self.processedResultSexLabel.text = gender
                }
                
                //5. Show Processed IDFront-Image
                if let idFrontImage = self.getImageFrom(base64String: response.responseCustomerData?.extractedIdData?.idProcessImageFront){
                    self.processedResultIdFrontImageView.image = idFrontImage
                    self.processedResultIdFrontImageView.isHidden = false
                    
                    let expectedImageViewHeight = self.getViewsAspectRatioHeight(image: idFrontImage, viewWidth: self.processedResultIdImageView_SatckView.frame.size.width)
                    if expectedImageViewHeight > 200 {
                        let differenceHeight = expectedImageViewHeight - 200
                        self.processedResultContainerView_HeightConstraint.constant += differenceHeight
                    } else {
                        self.processedResultIdFrontImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
                    }

                } else{
                    self.processedResultContainerView_HeightConstraint.constant -= 200
                }

                //6. Show Processed IDBack-Image
                if let idBackImage = self.getImageFrom(base64String: response.responseCustomerData?.extractedIdData?.idProcessImageBack){
                    self.processedResultIdBackImageView.image = idBackImage
                    self.processedResultIdBackImageView.isHidden = false
                    
                    let expectedImageViewHeight = self.getViewsAspectRatioHeight(image: idBackImage, viewWidth: self.processedResultIdImageView_SatckView.frame.size.width)
                    if expectedImageViewHeight > 200 {
                        let differenceHeight = expectedImageViewHeight - 200
                        self.processedResultContainerView_HeightConstraint.constant += differenceHeight
                    } else {
                        self.processedResultIdBackImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
                    }

                } else{
                    self.processedResultContainerView_HeightConstraint.constant -= 230
                }
                
                //7. Show DMV, AML/KYC, SexOffender/Criminal Result
//                if UserDefaults.serviceOptions.verifyDataWithHost == true {
//                    self.procResltAMLKYC_SatckView_HeightConstraint.isActive = false
//                    self.show_DMV_AMKKYC_CriRecSexOff_Result(host_Data: hostData)
//                } else {
                    self.hide_DMV_AMKKYC_CriRecSexOff_Result()
//                }

                //8. Adjust Extra Height
                let nameLabel_Height = self.processedResultFullNameLabel.intrinsicContentSize.height
                let addressLabel_Height = self.processedResultAdressLabel.intrinsicContentSize.height
                if nameLabel_Height > 17 {
                    self.processedResultContainerView_HeightConstraint.constant += (nameLabel_Height-17)
                }
                if addressLabel_Height > 17 {
                    self.processedResultContainerView_HeightConstraint.constant += (addressLabel_Height-17)
                }
                
            case .failure(let error):
                print(error)
                self.processedResultLabel.isHidden = false
                self.processedResultLabel.text = error.localizedDescription
                self.processedResultLabel.textColor = .red
            }
            
            
        }
        
    }
    
    private func show_DMV_AMKKYC_CriRecSexOff_Result(host_Data:HostdataResponse?) {
        
        let hostServerData = hostDataResponse(dictionary: host_Data)
        
        let resultDMV      : String? = hostServerData.textMatchResult?.thirdPartyVerificationResultDescription
        let resultCountPEP : String? = hostServerData.pepresult?.resultCountPEP
        let resultCountWLS : String? = hostServerData.wlsresult?.resultCountWLS
        let resultCountNM  : String? = hostServerData.nmresult?.resultCountNM
        let resultStatusCR : profilesData? = hostServerData.criminalRecord?.profiles
        let resultStatusSO : profilesData? = hostServerData.sexOffenders?.profiles
        
        var passStatus : Bool = false
        var reviewRequiredStatus : Bool = false
        
        //1. DMV Result
        if let DMV_Status = resultDMV {
            if DMV_Status == "DMV Data Match" {
                procResltDMV_StatusLabel.text = "Pass"
                procResltDMV_StatusImageView.image = UIImage(named: "icon_pass")
            } else if DMV_Status == "DMV Data Mismatch" {
                procResltDMV_StatusLabel.text = "Failed"
                procResltDMV_StatusImageView.image = UIImage(named: "icon_failed")
            } else {
                procResltDMV_StatusLabel.text = "NA"
                procResltDMV_StatusImageView.isHidden = true
                procResltDMV_StatusIndicatorImageWidth.constant = 0
            }
        } else {
            procResltDMV_StatusLabel.text = "NA"
            procResltDMV_StatusImageView.isHidden = true
            procResltDMV_StatusIndicatorImageWidth.constant = 0
        }

        
        //2. Show PEP Result
        if let PEP_Count = resultCountPEP, PEP_Count != "" {
            if Int(PEP_Count) == 0 {
                procResltAMLKYC_PEPImageView.isHidden = false
                procResltAMLKYC_PEPCountLabel.isHidden = true
                passStatus = true
            } else {
                procResltAMLKYC_PEPImageView.isHidden = true
                procResltAMLKYC_PEPCountLabel.isHidden = false
                procResltAMLKYC_PEPCountLabel.text = PEP_Count
                reviewRequiredStatus = true
            }
        } else {
            procResltAMLKYC_PEP_SatckView.isHidden = true
            procResltAMLKYC_PEPIndicatorHeight.constant = 0
            self.processedResultContainerView_HeightConstraint.constant -= 22.5
        }
        
        //3. Show WLS Result
        if let WLS_Count = resultCountWLS, WLS_Count != "" {
            if Int(WLS_Count) == 0 {
                procResltAMLKYC_WLImageView.isHidden = false
                procResltAMLKYC_WLCountLabel.isHidden = true
                passStatus = true
            } else {
                procResltAMLKYC_WLImageView.isHidden = true
                procResltAMLKYC_WLCountLabel.isHidden = false
                procResltAMLKYC_WLCountLabel.text = WLS_Count
                reviewRequiredStatus = true
            }
        } else {
            procResltAMLKYC_WL_SatckView.isHidden = true
            procResltAMLKYC_WLIndicatorHeight.constant = 0
            self.processedResultContainerView_HeightConstraint.constant -= 22.5
        }
        
        //4. Show NM Result
        if let NM_Count = resultCountNM, NM_Count != "" {
            if Int(NM_Count) == 0 {
                procResltAMLKYC_NMImageView.isHidden = false
                procResltAMLKYC_NMCountLabel.isHidden = true
                passStatus = true
            } else {
                procResltAMLKYC_NMImageView.isHidden = true
                procResltAMLKYC_NMCountLabel.isHidden = false
                procResltAMLKYC_NMCountLabel.text = NM_Count
                reviewRequiredStatus = true
            }
        } else {
            procResltAMLKYC_NM_SatckView.isHidden = true
            procResltAMLKYC_NMIndicatorHeight.constant = 0
            self.processedResultContainerView_HeightConstraint.constant -= 22.5
        }
        
        //5. Show Criminal Record Result
        if let CR_Status = resultStatusCR {
            if let CR_internalID = CR_Status.internalId, CR_internalID != "" {
                procResltAMLKYC_CRImageView.image = UIImage(named: "icon_tick_failed")
                reviewRequiredStatus = true
            } else {
                procResltAMLKYC_CRImageView.image = UIImage(named: "icon_tick_success")
                passStatus = true
            }
        } else {
            procResltAMLKYC_CR_SatckView.isHidden = true
            procResltAMLKYC_CRIndicatorHeight.constant = 0
            self.processedResultContainerView_HeightConstraint.constant -= 22.5
        }
        
        //6. Show Sex Offender Result
        if let SO_Status = resultStatusSO {
            if let SO_internalID = SO_Status.internalId, SO_internalID != "" {
                procResltAMLKYC_SOImageView.image = UIImage(named: "icon_tick_failed")
                reviewRequiredStatus = true
            } else {
                procResltAMLKYC_SOImageView.image = UIImage(named: "icon_tick_success")
                passStatus = true
            }
        } else {
            procResltAMLKYC_SO_SatckView.isHidden = true
            procResltAMLKYC_SOIndicatorHeight.constant = 0
            self.processedResultContainerView_HeightConstraint.constant -= 22.5
        }
        
        
        if !passStatus && !reviewRequiredStatus {
            procResltAMLKYC_StatusLabel.text = "NA"
            procResltAMLKYC_StatusIndicator_StackViewWidth.constant = 0
        } else if passStatus && !reviewRequiredStatus {
            procResltAMLKYC_StatusLabel.text = "Pass"
            procResltAMLKYC_StatusImageView.image = UIImage(named: "icon_pass")
        } else {
            procResltAMLKYC_StatusLabel.text = "Review Required"
            procResltAMLKYC_StatusImageView.image = UIImage(named: "icon_review_required")
        }
        
    }
    
    func hide_DMV_AMKKYC_CriRecSexOff_Result() {
        
        //1. Make DMV Result to 0 Height
        self.procResltDMV_SatckView.isHidden = true
        self.procResltDMV_SatckView_HeightConstraint.constant = 0 //its value is 54
        self.procResltDMV_TopSeparator_HeightConstraint.constant = 0 //its value is 1
        self.procResltDMV_BottomSeparator_HeightConstraint.constant = 0 //its value is 1
        self.processedResultContainerView_HeightConstraint.constant -= (54 + 1 + 1)

        //2. Make PEP Result to 0 Height
        self.procResltAMLKYC_PEP_SatckView.isHidden = true
        self.procResltAMLKYC_PEPIndicatorHeight.constant = 0 //its value is 22.5
        self.processedResultContainerView_HeightConstraint.constant -= 22.5

        //3. Make WLS Result to 0 Height
        self.procResltAMLKYC_WL_SatckView.isHidden = true
        self.procResltAMLKYC_WLIndicatorHeight.constant = 0 //its value is 22.5
        self.processedResultContainerView_HeightConstraint.constant -= 22.5

        //4. Make NM Result to 0 Height
        self.procResltAMLKYC_NM_SatckView.isHidden = true
        self.procResltAMLKYC_NMIndicatorHeight.constant = 0 //its value is 22.5
        self.processedResultContainerView_HeightConstraint.constant -= 22.5

        //5. Make Criminal Record Result to 0 Height
        self.procResltAMLKYC_CR_SatckView.isHidden = true
        self.procResltAMLKYC_CRIndicatorHeight.constant = 0 //its value is 22.5
        self.processedResultContainerView_HeightConstraint.constant -= 22.5

        //6. Make Sex Offender Result to 0 Height
        self.procResltAMLKYC_SO_SatckView.isHidden = true
        self.procResltAMLKYC_SOIndicatorHeight.constant = 0 //its value is 22.5
        self.processedResultContainerView_HeightConstraint.constant -= 22.5

        //7. Make Sex Offender Result to 0 Height
        self.procResltAMLKYC_Status_SatckView.isHidden = true
        self.procResltAMLKYC_StatusIndicatorTopSpacing.constant = 0 //its value is 6.5
        self.procResltAMLKYC_StatusIndicatorBottomSpacing.constant = 0 //its value is 9.5
        self.procResltAMLKYC_StatusIndicatorHeight.constant = 0 //its value is 6.5
        self.processedResultContainerView_HeightConstraint.constant -= 22.5

        //8. Make AMLKYC Top-Bottom to 0 height
//        self.procResltAMLKYC_SatckView.isHidden = true
        self.procResltAMLKYC_SatckView_TopConstraint.constant = 0 //its value is 10
        self.procResltAMLKYC_SatckView_BottomConstraint.constant = 0 //its value is 10
        self.processedResultContainerView_HeightConstraint.constant -= (10 + 10)
        self.procResltAMLKYC_SatckView_HeightConstraint.constant = 0
    }

}

//MARK: - Helper Methods
extension ResultScreenFor50{

    private func getAddressFromResponse(response:CustomerEnrollResponse) -> String? {
        
        if let address = response.responseCustomerData?.extractedPersonalData?.address {
            return address
        } else {
            var processedResultAddress = response.responseCustomerData?.extractedPersonalData?.addressLine1 ?? ""
            processedResultAddress += " "
            processedResultAddress += response.responseCustomerData?.extractedPersonalData?.addressLine2 ?? ""
            processedResultAddress += " "
            processedResultAddress += response.responseCustomerData?.extractedPersonalData?.addressLine3 ?? ""
            processedResultAddress += " "
            processedResultAddress += response.responseCustomerData?.extractedPersonalData?.country ?? ""
            return processedResultAddress
        }
        
    }
        
}
