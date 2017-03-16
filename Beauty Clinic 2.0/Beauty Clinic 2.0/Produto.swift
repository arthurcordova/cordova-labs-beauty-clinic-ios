//
//  Produto.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 01/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class Produto: NSObject {
    
    var codProduto: NSNumber!
    var descricao: String!
    var valorProduto: NSNumber!
    var tipoExame: String!
    var qtd: Int!
    
    init(json: NSDictionary) {
        super.init()
        let jsonDictionary: Dictionary = json as! [String:AnyObject]
        setValuesForKeys(jsonDictionary)
    }
    
    override init() {
        super.init()
    }
    
}

