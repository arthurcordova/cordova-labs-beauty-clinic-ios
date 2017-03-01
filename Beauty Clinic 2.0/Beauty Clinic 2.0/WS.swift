//
//  WS.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 28/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import Foundation

class WS: NSObject {
    
    
    static func getRequestLogin(urlBase:String, user : Usuario, completionHander: @escaping (Dictionary<String,AnyObject>, Error?) -> Void) {
        
        let url     = URL(string: urlBase)
        var request = URLRequest(url:url!)
        
        let params = ["cpfcnpj":user.cpf as AnyObject, "senha":user.senha as AnyObject, "codFilial":3 as AnyObject] as Dictionary<String, AnyObject>
        
        do {
            request.httpMethod = "POST"
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        } catch let error as NSError {
            print("erro ao inicializar json: \(error.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:.allowFragments) as! Dictionary<String,AnyObject>
                    
                    print(jsonResult)
                    
                    completionHander(jsonResult as Dictionary<String,AnyObject >,nil)
                    
                    
                } catch {
                    if let httpResponse = response as? HTTPURLResponse {
                        print(httpResponse.statusCode)
                    }
                }
                
            } else {
                print("Connection Error")
            }
            
        }
        task.resume()
    }
    
}
