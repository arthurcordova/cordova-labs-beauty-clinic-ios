//
//  Agendamento.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 05/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class Agendamento: NSObject {
    
    var codAgenda: NSNumber!
    var codProcedimento: NSNumber!
    var descProcedimento: String!
    var codAngariador: NSNumber!
    var data: String!
    var horario: String!
    var repetido: String!
    var status: String!
    
    init(json: NSDictionary) {
        super.init()
        let jsonDictionary: Dictionary = json as! [String:AnyObject]
        setValuesForKeys(jsonDictionary)
    }
    
    override init() {
        super.init()
    }

    
}
