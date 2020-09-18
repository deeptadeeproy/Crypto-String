//
//  ViewController.swift
//  Crypto String
//
//  Created by Deeptadeep Roy on 18/09/20.
//  Copyright © 2020 Deeptadeep Roy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var encryptButton: UIButton!
    @IBOutlet weak var decryptButton: UIButton!
    
    var encryptDecrypt : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func encrpytBtnPressed(_ sender: Any) {
        encryptDecrypt = true
        performSegue(withIdentifier: "encryptDecryptSegue", sender: self)
    }
    
    @IBAction func decryptBtnPressed(_ sender: Any) {
        encryptDecrypt = false
        performSegue(withIdentifier: "encryptDecryptSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "encryptDecryptSegue" {
            let destinationVC = segue.destination as? Encrypt_DecryptVC
            destinationVC?.encryptDecrypt = self.encryptDecrypt
        }
    }
    
}

