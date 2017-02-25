//
//  NovoUsuarioService.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 21/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import Foundation

class UsuarioService: ServiceConfig {
    
    let controller : CadastroController?
    
    init(viewController: CadastroController) {
        self.controller = viewController
        self.controller?.progress.startAnimating()
    }
    
    func novo(usuario: Usuario) -> Void {
        var request = URLRequest(url: URL(string: server.appending("/cadcliente"))!)
        request.httpMethod = "POST"
        let postString = "codFilial=\(usuario.filial)" +
            "&cpfcnpj=\(usuario.cpf)" +
            "&nome=\(usuario.nome)" +
            "&opcad=\(usuario.opcao)" +
            "&senha=\(usuario.senha)" +
            "&tipopessoa=\(usuario.tipoPessoa)"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                self.controller?.progress.stopAnimating()
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                self.controller?.httpStatusCode = httpStatus.statusCode
                self.controller?.progress.stopAnimating()
                self.controller?.viewMsg.layer.isHidden = true
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            self.controller?.httpStatusCode = 200
            self.controller?.progress.stopAnimating()
            
            return
        }
        task.resume()
    }
    
}
