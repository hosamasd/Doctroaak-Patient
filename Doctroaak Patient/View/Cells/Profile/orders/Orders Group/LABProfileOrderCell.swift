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
            profileOrderDatesLabel.text = pharamacy.createdAt
            let urlString = pharamacy.photo
            guard let url = URL(string: urlString) else { return  }
            pharamacyImage.sd_setImage(with: url)
        }
    }
    
    lazy var profileOrderDatesLabel = UILabel(text: "22/4/2020  2:30 pm", font: .systemFont(ofSize: 16), textColor: .lightGray,textAlignment: .center)
    lazy var pharamacyImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.isUserInteractionEnabled = true
               i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenImage)))
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
        b.addTarget(self, action: #selector(handleCacnel), for: .touchUpInside)

        return b
    }()
    lazy var addLapCollectionVC:AddLapCollectionVC = {
        let vc = AddLapCollectionVC()
        return vc
    }()
    
    var handleCheckedIOpenImage:((UIImage)->Void)?
    var handleCheckedIndex:((LABOrderPatientModel)->Void)?

    
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
    
    @objc func handleOpenImage()  {
        handleCheckedIOpenImage?(pharamacyImage.image ?? UIImage())
    }
    
    @objc   func handleCacnel()  {
    guard let pharamacy = pharamacy else { return  }
        handleCheckedIndex?(pharamacy)
    }
}
