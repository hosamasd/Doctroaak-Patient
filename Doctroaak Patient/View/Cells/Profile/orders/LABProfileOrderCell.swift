//
//  LABProfileOrderCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/2/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LABProfileOrderCell: BaseCollectionCell {

    var pharamacy:LABOrderPatientModel?{
           didSet{
               guard let pharamacy = pharamacy else { return  }
           }
       }
    
    override func setupViews() {
        
    }
}
