//
//  Encrypt-DecryptVC.swift
//  Crypto String
//
//  Created by Deeptadeep Roy on 18/09/20.
//  Copyright © 2020 Deeptadeep Roy. All rights reserved.
//

import UIKit

class Encrypt_DecryptVC: UIViewController, UITextFieldDelegate {
    
    var encryptDecrypt: Bool!
    @IBOutlet weak var inputTxtField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }
    
    func prepare() {
        if encryptDecrypt == true {
            self.title = "Encrypt"
        }
        else {
            self.title = "Decrypt"
        }
        inputTxtField.delegate = self
        submitButton.isUserInteractionEnabled = false
        submitButton.alpha = 0.5
        resultLabel.text = ""
    }
    
    //Separating words in a sentence from input
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if !text.isEmpty{
            submitButton?.isUserInteractionEnabled = true
            submitButton?.alpha = 1.0
        } else {
            submitButton?.isUserInteractionEnabled = false
            submitButton?.alpha = 0.5
            
        }
        return true
    }
    
    
    //MARK:- Submit Button function
    @IBAction func submitBtnPressed(_ sender: Any) {
        if encryptDecrypt == true {
            self.Encrypt(inputTxtField.text!)
        }
        else if encryptDecrypt == false {
            self.Decrypt(inputTxtField.text!)
        }
    }
    
    //MARK:- Encrypt function
    func Encrypt (_ textInput: String) {
        let wordsArr = inputTxtField.text!.components(separatedBy: " ")
        var finalString = ""
        var charCount = 1
        
        for i in 0..<wordsArr.count {
            var wordString = ""
            if wordsArr[i].count == 1 {
                wordString = wordsArr[i][0] + "1"
            }
            else {
                for j in 0..<wordsArr[i].count {
                    if j != wordsArr[i].count-1{
                        if wordsArr[i][j] == wordsArr[i][j+1] {
                            charCount += 1
                        }
                        else {
                            wordString = wordString + wordsArr[i][j] + String(charCount)
                            charCount = 1
                        }
                    }
                    if j == wordsArr[i].count-1 {
                        if wordsArr[i][j] != wordsArr[i][j-1] {
                            wordString = wordString + wordsArr[i][j] + "1"
                        }
                        else {
                            wordString = wordString + wordsArr[i][j] + String(charCount)
                        }
                    }
                }
            }
            if i != 0 {
                wordString = "1" + wordString
            }
            if i != wordsArr.count-1 {
                wordString = wordString + " "
            }
            finalString = finalString + wordString
        }
        self.resultLabel.text = finalString
    }
    
    //MARK:- Decrypt function
    func Decrypt (_ textInput: String) {
        let wordsArr = inputTxtField.text!.components(separatedBy: " ")
        var finalResult = ""
        for i in 0..<wordsArr.count {
            var wordString = ""
            
            //Invalid Input Cases
            for j in 0..<wordsArr[i].count{
                if i == 0 && j == 0 && Int(wordsArr[i][j]) != nil{
                    resultLabel.text = "Invalid Input"
                    break
                }
                if j == wordsArr[i].count-1 && Int(wordsArr[i][j]) == nil {
                    resultLabel.text = "Invalid Input"
                    break
                }
                if i != 0 && j == 0 && Int(wordsArr[i][j]) == nil{
                    resultLabel.text = "Invalid Input"
                    break
                }
                
                //Decryption Logic
                if i == 0 {
                    if j%2 == 0 {
                        let count = (wordsArr[i][j+1] as NSString).integerValue
                        for _ in 0..<count {
                            wordString = wordString + wordsArr[i][j]
                        }
                    }
                }
                else {
                    if j%2 != 0 {
                        let count = (wordsArr[i][j+1] as NSString).integerValue
                        for _ in 0..<count {
                            wordString = wordString + wordsArr[i][j]
                        }
                    }
                }
            }
            if i != wordsArr.count-1 {
                wordString = wordString + " "
            }
            finalResult = finalResult + wordString
        }
        self.resultLabel.text = finalResult
    }
    
}

//MARK:- String extension
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
