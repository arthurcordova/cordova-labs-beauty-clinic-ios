//
//  DrawerMenuController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 25/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class DrawerMenuController: UIViewController /*, UIGestureRecognizerDelegate */ {
    
    @IBOutlet var labelNome: UILabel!
    @IBOutlet var mainView: UIView!
    
    var pessoa : Pessoa? = nil
    var principalController: PrincipalController?
    var centerX : CGFloat!
    
    override func viewDidLoad() {
        
        labelNome.text = pessoa?.nome
        
//        //Left Close View
//        centerX = CGFloat()
//        centerX = self.view.center.x - 10
//        
//        let edgeLeftGesture =  UIPanGestureRecognizer(target:self, action: #selector(self.leftCloseView(sender:)))
//        edgeLeftGesture.delegate = self
//        self.mainView.addGestureRecognizer(edgeLeftGesture)

    }
    
    func leftCloseView (sender : UIPanGestureRecognizer) {
        
        let startPoint = sender.location(in: mainView)
        let point = sender.translation(in: mainView)
        let velocity = sender.velocity(in: mainView)
        
        if ((velocity.x <  0) || (velocity.y != 0  && velocity.x < 0)) {
            
            if  (sender.state == UIGestureRecognizerState.began ||
                sender.state == UIGestureRecognizerState.changed) {
                mainView.center = CGPoint(x: centerX + CGFloat(point.x), y: self.mainView.center.y)
                
            } else  if sender.state == UIGestureRecognizerState.ended {
                
                let distance =  startPoint.x + point.x
                
                if  velocity.x < (-1500) {
                    UIView.animate(withDuration: 3, animations: {
                        self.dismiss(animated: false, completion: nil)
                    })
                    
                } else if (distance < 30 && startPoint.x > (self.mainView.frame.width / 2) )  {
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        self.dismiss(animated: false, completion: nil)
                    })
                }
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainView.center = CGPoint(x: self.centerX, y: self.mainView.center.y)
                })
                
            }
        } else {
            if sender.state == UIGestureRecognizerState.ended {
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainView.center = CGPoint(x: self.centerX, y: self.mainView.center.y)
                })
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueMensagens" {
            
            if let toViewController = segue.destination as? MensagensController {
                toViewController.pessoa = pessoa
            }
        }
        
        if segue.identifier == "segueAgendamentos" {
            
            if let toViewController = segue.destination as? AgendamentosController {
                toViewController.pessoa = pessoa
            }
        }
        
        if segue.identifier == "segueOrcamentos" {
            
            if let toViewController = segue.destination as? OrcamentoController {
                toViewController.pessoa = pessoa
            }
        }
        
        if segue.identifier == "segueProdutos" {
            
            if let toViewController = segue.destination as? ProdutosController {
                toViewController.principalController = self.principalController
                
            }
        }
        
        if segue.identifier == "segueExecucoes" {
            
            if let toViewController = segue.destination as? ExecucoesController {
                toViewController.pessoa = pessoa
            }
        }
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        OperationQueue.main.addOperation {
            let mainNavigator = UINavigationController()
            
            let principal: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = principal.instantiateViewController(withIdentifier: "loginID") as! LoginController
            
            mainNavigator.setNavigationBarHidden(true, animated: false)
            mainNavigator.pushViewController(controller, animated: true)
            
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window!.rootViewController = mainNavigator
        }
    }
    
}
