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
    
    @IBAction func loginAction(_ sender: UIButton) {
//        callViewPrincipal()
//        let service = LoginService()
//        let usuario = Usuario()
//        usuario.cpf = inputLogin.text!
//        usuario.senha = inputSenha.text!
//        service.doLogin(usuario: usuario, completionHander: { (dic, error) in
//            print(dic)
//            
//           
//
//            
//        })
    }
    
    
    @IBAction func backView(segue:UIStoryboardSegue) {
        
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
    
//    func callViewPrincipal() {
//        let principal: UIStoryboard = UIStoryboard(name: "Principal", bundle: nil)
//        let controller = principal.instantiateViewController(withIdentifier: "principalID") as! PrincipalController
//        self.navigationController?.pushViewController(controller, animated: true);
//        print("Chamando view")
//    }
    
}
