//
//  CadastroController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 21/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class CadastroController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var inputNome: UITextField!
    @IBOutlet var inputCpf: UITextField!
    @IBOutlet var inputSenha: UITextField!
    
    override func viewDidLoad() {
        inputNome.delegate = self
        inputNome.tag = 0
        inputCpf.delegate = self
        inputCpf.tag = 1
        inputSenha.delegate = self
        inputSenha.tag = 2
        
        designTextField(textField: inputNome)
        designTextField(textField: inputCpf)
        designTextField(textField: inputSenha)
    }
    
    func designTextField(textField: UITextField) {
        textField.borderStyle = .none
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 0.0
    }
    
    //Hide keyboard when user touches outside key
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            enviar()
        }
        // Do not add a line break
        return false
    }
    
    func enviar() -> Void {
        print("Enviando")
    }
}
