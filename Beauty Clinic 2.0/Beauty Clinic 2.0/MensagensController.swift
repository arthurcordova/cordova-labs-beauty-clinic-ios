//
//  MensagensController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 26/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class MensagensController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableMensagens: UITableView!
    @IBOutlet var buttonFiltro: UIButton!
    
    override func viewDidLoad() {
        tableMensagens.delegate = self
        tableMensagens.dataSource = self
        tableMensagens.separatorStyle = UITableViewCellSeparatorStyle.none
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MensagemCellTableViewCell = self.tableMensagens.dequeueReusableCell(withIdentifier: "cellMensagem") as! MensagemCellTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        
//        cell.appointmentDay.text  = appintmentsList[indexPath.row]
//        setupAppointmentsViews(stack: cell.appointStackView)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              
    }

    
}
