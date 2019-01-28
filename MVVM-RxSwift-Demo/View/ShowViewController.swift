//
//  ShowViewController.swift
//  MVVM-SendText
//
//  Created by Ice on 23/1/2562 BE.
//  Copyright © 2562 Ice. All rights reserved.
//

import UIKit
import RxSwift

class ShowViewController: UIViewController {
    
    
    @IBOutlet weak var ShowText: UILabel!
    @IBOutlet weak var LastNameText: UILabel!
    @IBOutlet weak var rxText: UILabel!
    
    let dispose = DisposeBag()
    
    var ShowData:DataViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }
    
    private func setData(){
        guard let vm = ShowData else {return}
        ShowText.text = vm.FirtName
        LastNameText.text = vm.LastName
    }
    
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        let selectedAddVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTextStoryboard") as! AddTextViewController
        
        selectedAddVC.selectedObserver
            .subscribe(onNext : {[weak self] textName in
                if textName.count > 0{
                    self?.rxText.text = textName
                }
            }).disposed(by: dispose)
        self.navigationController?.pushViewController(selectedAddVC, animated: true)
    }
    
}

