//
//  Horario.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 05/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class Horario: NSObject {
    
    var codSala : NSNumber!
    var horarioInicial: String!
    var intervaloMinutos: NSNumber!
    
    init(json: NSDictionary) {
        super.init()
        let jsonDictionary: Dictionary = json as! [String:AnyObject]
        setValuesForKeys(jsonDictionary)
    }
    
    override init() {
        super.init()
    }

}
