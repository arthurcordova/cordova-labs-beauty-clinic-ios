//
//  LoginController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 20/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var inputLogin: UITextField!
    @IBOutlet var inputSenha: UITextField!
    @IBOutlet var buttonLogin: UIButton!
    @IBOutlet var buttonCadastro: UIButton!
    
    
    override func viewDidLoad() {
        
        designTextField(textField: inputLogin)
        designTextField(textField: inputSenha)
        designButtonFill(button: buttonLogin)
        designButtonStroke(button: buttonCadastro)
        
        inputSenha.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 11
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= maxLength
    }

    
    @IBAction func backToLogin(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
        
        if inputLogin.text != "" && inputSenha.text != "" {
            let usuario = Usuario()
            usuario.cpf = inputLogin.text!
            usuario.senha = inputSenha.text!
            
            
            WS.getRequestLogin(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/login", user: usuario, completionHander: { (dic, msg, error) in
                if error != nil {
                    print(dic)
                } else {
                    
                    if msg != "" {
                        OperationQueue.main.addOperation {
                            let addAlerta = UIAlertController(title: "Erro", message: msg, preferredStyle: UIAlertControllerStyle.alert)
                            addAlerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                            self.present(addAlerta, animated: true, completion: nil)
                            
                        }
                        
                    } else {
                        let pessoa = Pessoa()
                        pessoa.nome = dic["fantasia"] as! String
                        pessoa.cpf = dic["cpfcnpj"] as! String
                        pessoa.code = dic["codcliente"] as! Int
                        
                        OperationQueue.main.addOperation {
                            let mainNavigator = UINavigationController()
                            
                            let principal: UIStoryboard = UIStoryboard(name: "Principal", bundle: nil)
                            let controller = principal.instantiateViewController(withIdentifier: "principalID") as! PrincipalController
                            controller.pessoa = pessoa
                            
                            mainNavigator.setNavigationBarHidden(true, animated: false)
                            
                            mainNavigator.pushViewController(controller, animated: true)
                            
                            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                            appDelegate.window!.rootViewController = mainNavigator
                            
                        }
                    }
                }
            })
        } else {
            OperationQueue.main.addOperation {
                let addAlerta = UIAlertController(title: "Erro", message: "Por favor, informe seu login e senha para continuar.", preferredStyle: UIAlertControllerStyle.alert)
                addAlerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                self.present(addAlerta, animated: true, completion: nil)
                
            }

        }
        
    }
    
    @IBAction func backView(segue:UIStoryboardSegue) {
        print("LOGIN")
    }
    
    //Hide keyboard when user touches outside key
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
    
    func designButtonFill (button: UIButton) {
        button.layer.cornerRadius = 8
    }
    
    func designButtonStroke (button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 8
    }
    
    func callViewPrincipal() {
        
    }
    
}
