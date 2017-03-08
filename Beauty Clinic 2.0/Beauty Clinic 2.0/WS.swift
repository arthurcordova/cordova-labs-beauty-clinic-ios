
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
    
    static func newScheduling(urlBase:String, novo : NovoAgendamento, completionHander: @escaping (_ httpCode: Int , Error?) -> Void) {
        
        let url     = URL(string: urlBase)
        var request = URLRequest(url:url!)
        
        let params = ["codCliente": novo.codCli as AnyObject, "data": novo.data as AnyObject, "horario": novo.hora as AnyObject, "codFilial":3 as AnyObject, "codProcedimento": novo.produto.codProduto as Int!  as AnyObject] as Dictionary<String, AnyObject>
        
        do {
            request.httpMethod = "POST"
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch let error as NSError {
            print("erro ao inicializar json: \(error.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                completionHander(httpResponse.statusCode as Int, nil)
            }
        }
        task.resume()
    }
    
    static func newOrcamento(urlBase:String, client : Int, date: String, value : NSNumber, completionHander: @escaping (_ codOrc: String , Error?) -> Void) {
        
        let url     = URL(string: urlBase)
        var request = URLRequest(url:url!)
        
        let params = ["codAngariador": 42 as AnyObject,
                      "codCliente": client as AnyObject,
                      "codFilial": 3 as AnyObject,
                      "codVendedor":42 as AnyObject,
                      "dataOrcamento": date as AnyObject,
                      "opcad":42 as AnyObject,
                      "status":"P" as AnyObject,
                      "valorDesconto":0.0 as AnyObject,
                      "valorOrcamento": value as AnyObject,
                      "valorTotal": value as AnyObject] as Dictionary<String, AnyObject>
        
        do {
            request.httpMethod = "POST"
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch let error as NSError {
            print("erro ao inicializar json: \(error.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                do {
                    
                    let codeOrc = try NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
                    print(codeOrc)
                    completionHander(codeOrc, nil)
                    
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
    
    //    {"codAngariador":42,"codIndicador":0,"codProduto":111,"duracao":0,"opcad":42,"valorProduto":2500.0}
    
    static func newOrcamentoProdutos(urlBase:String, produto : Int, value : NSNumber, completionHander: @escaping (_ httpCode: Int , Error?) -> Void) {
        
        let url     = URL(string: urlBase)
        var request = URLRequest(url:url!)
        
        let params = ["codAngariador": 24 as AnyObject,
                      "codIndicador": 0 as AnyObject,
                      "codProduto": produto as AnyObject,
                      "duracao": 0 as AnyObject,
                      "opcad":42 as AnyObject,
                      "valorProduto": value as AnyObject] as Dictionary<String, AnyObject>
        
        do {
            request.httpMethod = "POST"
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch let error as NSError {
            print("erro ao inicializar json: \(error.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                completionHander(httpResponse.statusCode as Int, nil)
            }
        }
        task.resume()
    }
    
    static func jsonToArrayObjects (urlBase:String, completionHander: @escaping (Array<NSDictionary>?, Error?) -> Void) {
        
        let url     = URL(string: urlBase)
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:.allowFragments) as! Array<NSDictionary>
                    
                    
                    
                    completionHander(jsonResult as Array<NSDictionary>?,nil)
                    
                    
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
    
    static func deleteMensagem(id: NSNumber){
        let http = URLSession.shared
        let url = NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/excluirmsg/"+"\(id)")!
        let task = http.dataTask(with: url as URL)
        print("delete from server \(id)")
        task.resume()
    }
    
}

