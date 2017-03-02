//
//  Orcamento.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 01/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class Orcamento: NSObject {
    
    var codOrcamento: NSNumber!
    var status: String!
    var valorOrcamento: NSNumber!
    var valorDesconto: NSNumber!
    var valorTotal: NSNumber!
    var dataOrcamento: String!
    
    init(json: NSDictionary) {
        super.init()
        let jsonDictionary: Dictionary = json as! [String:AnyObject]
        setValuesForKeys(jsonDictionary)
    }
    
    override init() {
        super.init()
    }
    
}
