//
//  AddTextViewController.swift
//  MVVM-SendText
//
//  Created by Ice on 28/1/2562 BE.
//  Copyright © 2562 Ice. All rights reserved.
//

import UIKit
import RxSwift

class AddTextViewController: UIViewController {
    
    @IBOutlet weak var rxTextField: UITextField!
    private let selectedVariable = Variable("")
    var selectedObserver:Observable<String>{
        return selectedVariable.asObservable()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Rx Text"
        
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        guard let textName = rxTextField.text else{return}
        selectedVariable.value = textName
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

