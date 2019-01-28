//
//  DataViewModel.swift
//  MVVM-SendText
//
//  Created by Ice on 23/1/2562 BE.
//  Copyright © 2562 Ice. All rights reserved.
//

import Foundation
class DataViewModel{
    
    private var myName:Data
    
    init(Fname:String,Lname:String) {
        myName = Data(FirstName: Fname, LastName: Lname)
    }
    
    var FirtName:String{
        return myName.FirstName
    }
    
    var LastName:String{
        return myName.LastName
    }
    
}

