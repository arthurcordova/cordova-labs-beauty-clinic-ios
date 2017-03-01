//
//  Mensagem.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 26/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class Mensagem: NSObject {
    
    var id: NSNumber!
    var titulo: String!
    var autor: String!
    var mensagem: String!
    var tipoMensagem: String!
    var dataEnvio: String!
    var visualizada: NSNumber!
    var idMsgCliente: NSNumber!
    
    init(json: NSDictionary) {
        super.init()
        let jsonDictionary: Dictionary = json as! [String:AnyObject]
        setValuesForKeys(jsonDictionary)
    }
    
    override init() {
        super.init()
    }
    
}
