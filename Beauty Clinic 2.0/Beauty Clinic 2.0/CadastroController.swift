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
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if (textField == inputCpf) {
            //strSenha.becomeFirstResponder()
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 11
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= maxLength
    }
    
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        
//        if (textField == inputCpf) {
//            
//            let strCpf = textField.text!
//            
//            if (textField.text!.isEmpty) {
//                return true
//            }
//            
//            switch strCpf.characters.count {
//            case 3,6:
//                if (string != "") && (!textField.text!.hasSuffix(".")) {
//                    textField.text = textField.text!+"."
//                }
//                return true
//            case 9:
//                if (string != "") && (!textField.text!.hasSuffix("-")){
//                    textField.text = textField.text!+"-"
//                }
//                return true
//            case 12:
//                if (string != "") {
//                    return false
//                } else {
//                    return true
//                }
//                
//            default: true
//            }
//            return true
//        } else {
//            return true
//        }
//    }
    
    override func viewDidLoad() {
        progress.stopAnimating()
        viewMsg.layer.isHidden = true
        
//        inputNome.delegate = self
        inputNome.tag = 0
//        inputCpf.delegate = self
        inputCpf.tag = 1
//        inputSenha.delegate = self
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
//        let service = UsuarioService(viewController: self)
        let usuario = Usuario()
        usuario.cpf = inputCpf.text!
        usuario.senha = inputSenha.text!
        usuario.nome = inputNome.text!
        WS.newUser(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/cadcliente", user: usuario, completionHander: { (httpCode, error) in
            if error != nil {
                print(httpCode)
            } else {
                if httpCode == 200 {
                    OperationQueue.main.addOperation {
                        let addAlerta = UIAlertController(title: "Cadastro", message: "Cadastro realizado com sucesso!", preferredStyle: UIAlertControllerStyle.alert)
                        
                        addAlerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                            
                            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginID") as! LoginController
                        
                            appDelegate.window?.rootViewController = viewController
                            appDelegate.window?.makeKeyAndVisible()
                            
                        }))
                        self.present(addAlerta, animated: true, completion: nil)
                    }
                    
                } else {
                    OperationQueue.main.addOperation {
                        let addAlerta = UIAlertController(title: "Cadastro", message: "Erro. Não foi possível realizar o cadastro!", preferredStyle: UIAlertControllerStyle.alert)
                        
                        addAlerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                        self.present(addAlerta, animated: true, completion: nil)
                    }
                }
            }
        })
        
//        let httpStatus = service.novo(usuario: usuario)
//        print("HTTP STATUS \(httpStatus)")
    }
}
