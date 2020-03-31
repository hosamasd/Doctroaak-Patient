//
//  AddMedicineCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class AddMedicineCell: BaseCollectionCell {
    
    var med:MedicineModel!{
        didSet{
            nameLabel.text = med.name
            typeLabel.text = med.type
            countLabel.text = "\(med.count)"
        }
    }
    
    
    lazy var nameLabel = UILabel(text: "Name", font: .systemFont(ofSize: 20), textColor: .black,textAlignment: .left)
    lazy var typeLabel = UILabel(text: "Type", font: .systemFont(ofSize: 20), textColor: #colorLiteral(red: 0.3168245852, green: 0.709082067, blue: 0.8302568793, alpha: 1),textAlignment: .left)
    lazy var countLabel = UILabel(text: "3", font: .systemFont(ofSize: 20), textColor: #colorLiteral(red: 0.3168245852, green: 0.709082067, blue: 0.8302568793, alpha: 1),textAlignment: .center)

    lazy var leftImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Rectangle 1758"))
//        i.constrainWidth(constant: 80)
        i.constrainWidth(constant: 8)
        i.contentMode = .scaleAspectFit
        return i
    }()
    lazy var closeImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_clear_24px"))
        i.contentMode = .scaleAspectFill
        //        i.constrainWidth(constant: 80)
        i.constrainWidth(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var seperatorView:UIView = {
       let v = UIView(backgroundColor: .lightGray)
        v.constrainHeight(constant: 1)
        return v
    }()
    
    override func setupViews() {
        backgroundColor = .white
        countLabel.constrainWidth(constant: 80)
        hstack(leftImage,nameLabel,typeLabel,countLabel,closeImage,spacing:8,alignment:.center).withMargins(.init(top: 0, left: 8, bottom: 0, right: 8))
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 8, bottom: 0, right: 0))
    }
}
