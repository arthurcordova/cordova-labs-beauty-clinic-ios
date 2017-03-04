//
//  FilltroMensagemController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 04/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class FiltroMensagemController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pickerFiltro: UIPickerView!
    @IBOutlet var navFilter: UINavigationBar!
    
    var filterList = Array<String> ()
    var filterAllTypes : String!
    var mensagemController : MensagensController?

    
    override func viewDidLoad() {
        
        self.pickerFiltro.delegate = self
        self.pickerFiltro.dataSource = self
        
        createFilter()
        
    }
    
    func createFilter() {
        filterList = ["Todas","Lidas","Não lidas"]
        
//        self.pickerFiltro.selectRow((filterList.index(of: filterAllTypes))!, inComponent: 0, animated: true)
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        navFilter.topItem?.title = filterList[row]    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filterList[row]
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyAction(_ sender: UIBarButtonItem) {
        let title = navFilter.topItem?.title
        mensagemController?.buttonFiltro.setTitle(title, for: .normal)
//        dismiss(animated: true, completion: nil)
    }
}
