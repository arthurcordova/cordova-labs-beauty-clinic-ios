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
    @IBOutlet var viewMsg: UIView!
    @IBOutlet var progress: UIActivityIndicatorView!
    
    
    var httpStatusCode = 0
    
    override func viewDidLoad() {
        progress.stopAnimating()
        viewMsg.layer.isHidden = true
        
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
    @IBAction func btnEnviarAction(_ sender: UIBarButtonItem) {
        enviar()
    }
    
    func enviar() -> Void {
        let service = UsuarioService(viewController: self)
        let usuario = Usuario()
        usuario.cpf = inputCpf.text!
        usuario.senha = inputSenha.text!
        usuario.nome = inputNome.text!
        let httpStatus = service.novo(usuario: usuario)
        print("HTTP STATUS \(httpStatus)")
    }
}
