//
//  RadiologyProfileOrderCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/2/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class RadiologyProfileOrderCell: BaseCollectionCell {
    
    var pharamacy:RadiologyOrderPatientModel?{
           didSet{
               guard let pharamacy = pharamacy else { return  }
           }
       }
    
    lazy var profileOrderDatesLabel = UILabel(text: "22/4/2020  2:30 pm", font: .systemFont(ofSize: 16), textColor: .lightGray,textAlignment: .center)
       lazy var pharamacyImage:UIImageView = {
              let i = UIImageView(backgroundColor: .gray)
              return i
          }()
       
       lazy var cancelButton:UIButton = {
              let b = UIButton()
              b.setTitle("Cancel order", for: .normal)
              b.setTitleColor(.black, for: .normal)
              b.backgroundColor = .white
              b.constrainHeight(constant: 50)
              b.layer.cornerRadius = 8
              b.clipsToBounds = true
              return b
          }()
          
          override func layoutSubviews() {
              super.layoutSubviews()
              if cancelButton.backgroundColor != nil {
                  addGradientInSenderAndRemoveOther(sender: cancelButton)
                  cancelButton.setTitleColor(.white, for: .normal)
              }
          }
       override init(frame: CGRect) {
           super.init(frame: frame)
              makeBorder()
       }
       
        func makeBorder() {
           layer.borderWidth = 0.5
           layer.borderColor = UIColor.gray.cgColor
           layer.cornerRadius = 16
           clipsToBounds = true
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       override func setupViews() {
           profileOrderDatesLabel.constrainHeight(constant: 40)
           stack(profileOrderDatesLabel,pharamacyImage,cancelButton)
       }
}
