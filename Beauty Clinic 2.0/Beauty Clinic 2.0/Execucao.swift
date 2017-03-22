//
//  Execucao.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 21/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class Execucao: NSObject {
    
    var codigo: NSNumber!
    var data: String!
    var produto: String!
    var executor: String!
    var codOs: NSNumber!
    
    init(json: NSDictionary) {
        super.init()
        let jsonDictionary: Dictionary = json as! [String:AnyObject]
        setValuesForKeys(jsonDictionary)
    }
    
    override init() {
        super.init()
    }
    
}
