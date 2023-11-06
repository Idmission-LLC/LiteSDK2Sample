//
//  KYCViewController.swift
//  LiteSDK2Sample
//
//  Created by Amol Deshmukh on 29/04/22.
//

import UIKit
import IDentityLiteSDK
import SelfieCaptureLite
import IDCaptureLite

class KYCViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CompleteKYC(_ sender:Any) {
        
        // first prompt for the customer's unique number
        let alert = UIAlertController(title: "Unique Customer Number", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { textField in
            textField.placeholder = "Customer #"
            textField.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let uniqueNumber = alert.textFields?.first?.text, !uniqueNumber.isEmpty {
                self.startIDValidationAndCustomerEnroll(uniqueNumber: uniqueNumber)
            } else {
                self.CompleteKYC(sender)
            }
        }))
        present(alert, animated: true)
    }
    
    // Service Code 50 - ID Validation And Customer Enroll
    private func startIDValidationAndCustomerEnroll(uniqueNumber: String) {
        
        let personalData = PersonalCustomerCommonRequestEnrollDataV3(uniqueNumber: uniqueNumber)
        let options = AdditionalCustomerWFlagCommonDataV3()
        
        showCaptureTypePrompt { type in
            if type == .captureBack {
                self.showCaptureBackPrompt { captureBack in
                    IDentitySDK.idValidationAndCustomerEnroll(from: self, personalData: personalData, options: options, captureBack: captureBack) { result in
                        switch result {
                        case .success(let customerEnrollResult):
                            
                            //1. Show Client Side Extracted Data on View
                            let resultForIdVerificationCustomView = ResultScreenFor50(frame: self.view.bounds, customerEnroll_Result: customerEnrollResult)
                            resultForIdVerificationCustomView.delegate = self
                            resultForIdVerificationCustomView.tag = 1
                            self.view.addSubview(resultForIdVerificationCustomView)

                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                        
                    }
                }
                
            } else {
                self.showIDTypeCountryStatePrompt { idType, idCountry, idState in
                    // start ID capture, presenting it from this view controller
                    IDentitySDK.idValidationAndCustomerEnroll(from: self, personalData: personalData, options: options, idType: idType, idCountry: idCountry, idState: idState) { result in
                        switch result {
                        case .success(let customerEnrollResult):
                            
                            //1. Show Client Side Extracted Data on View
                            let resultForIdVerificationCustomView = ResultScreenFor50(frame: self.view.bounds, customerEnroll_Result: customerEnrollResult)
                            resultForIdVerificationCustomView.delegate = self
                            resultForIdVerificationCustomView.tag = 1
                            self.view.addSubview(resultForIdVerificationCustomView)

                            
                        case .failure(let error):
                            if error.localizedDescription == "Invalid ID Type / Country / State" {
                                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                                self.present(alert, animated: true)
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    
}

//MARK: - Done Button Delegate
extension KYCViewController : ResultScreenFor50Delegate {
    
    func doneButtonPressed() {
        if let viewWithTag = self.view.viewWithTag(1){
            viewWithTag.removeFromSuperview()
        }
    }
    
    func displayAlert(title : String, Message:String){
        let alert = UIAlertController(title: title, message: Message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    private func showCaptureBackPrompt(completion: @escaping BoolCompletion) {
        // first prompt the user to select if capturing a 2-sided ID
        let alert = UIAlertController(title: "Capture Back?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default) { _ in completion(false) })
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in completion(true) })
        present(alert, animated: true)
    }

    private func showCaptureTypePrompt(completion: @escaping CaptureTypeCompletion) {
        let alert = UIAlertController(title: "Select Capture Type", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Capture Back?", style: .default) { _ in completion(.captureBack) })
        alert.addAction(UIAlertAction(title: "ID Type / Country / State", style: .default) { _ in completion(.idTypeCountryState) })
        present(alert, animated: true)
    }

    private func showIDTypeCountryStatePrompt(completion: @escaping IDTypeCountryStateCompletion) {
        let alert = UIAlertController(title: "Enter ID Type / Country / State", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { textField in
            textField.placeholder = "ID Type"
            textField.keyboardType = .asciiCapable
            textField.autocapitalizationType = .allCharacters
            textField.returnKeyType = .next
        }
        alert.addTextField { textField in
            textField.placeholder = "ID Country"
            textField.keyboardType = .asciiCapable
            textField.autocapitalizationType = .allCharacters
            textField.returnKeyType = .next
        }
        alert.addTextField { textField in
            textField.placeholder = "ID State"
            textField.keyboardType = .asciiCapable
            textField.autocapitalizationType = .allCharacters
            textField.returnKeyType = .done
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let idType = alert.textFields?[0].text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let idCountry = alert.textFields?[1].text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let idState = alert.textFields?[2].text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            completion(idType, idCountry, idState)
        }))
        present(alert, animated: true)
    }
}

enum CaptureType { case captureBack, idTypeCountryState }
typealias CaptureTypeCompletion = (CaptureType) -> Void
typealias IDTypeCountryStateCompletion = (_ idType: String, _ idCountry: String, _ idState: String?) -> Void
