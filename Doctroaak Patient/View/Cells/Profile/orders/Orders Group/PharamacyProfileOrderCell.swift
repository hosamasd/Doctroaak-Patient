//
//  PharamacyProfileOrderCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/2/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class PharamacyProfileOrderCell: BaseCollectionCell {
    
    var pharamacy:PharamacyOrderPatientModel?{
        didSet{
            guard let pharamacy = pharamacy else { return  }
            var mmm = [PharamcyOrderModel]()
            profileOrderDatesLabel.text = pharamacy.updatedAt
            addMedicineCollectionVC.showOrderOnly = true
            if pharamacy.details?.count ?? 1 > 0 {
                guard let details = pharamacy.details else { return  }
                
                
                details.forEach { (d) in
                    let med = PharamcyOrderModel(medicineID: d.medicineID, medicineTypeID: d.medicineID, amount: d.amount)
                    mmm.append(med)
                    
                }
                addMedicineCollectionVC.view.isHide(false)
            }else {
                let urlString = pharamacy.photo
                guard let url = URL(string: urlString) else { return  }
                pharamacyImage.sd_setImage(with: url)

                addMedicineCollectionVC.view.isHide(true)
            }
            self.addMedicineCollectionVC.medicineArray = mmm
            
            DispatchQueue.main.async {
                self.addMedicineCollectionVC.collectionView.reloadData()
            }
        }
    }
    
    lazy var profileOrderDatesLabel = UILabel(text: "22/4/2020  2:30 pm", font: .systemFont(ofSize: 16), textColor: .lightGray,textAlignment: .center)
    lazy var pharamacyImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "pha"))
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
    lazy var addMedicineCollectionVC:AddMedicineCollectionVC = {
        let vc = AddMedicineCollectionVC()
        return vc
    }()
    
    var handleCheckedIOpenImage:((UIImage)->Void)?
    var handleCheckedIndex:((PharamacyOrderPatientModel)->Void)?
    
    
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
       
        let ss = getStack(views: pharamacyImage,addMedicineCollectionVC.view, spacing: 0, distribution: .fillEqually, axis: .vertical)

//        let ss = getStack(views: pharamacyImage,addMedicineCollectionVC.view, spacing: 0, distribution: .fillEqually, axis: .vertical)
        
        stack(profileOrderDatesLabel,ss,cancelButton)
    }
    
    @objc func handleOpenImage()  {
        handleCheckedIOpenImage?(pharamacyImage.image ?? UIImage())
    }
    
    @objc   func handleCacnel()  {
        guard let pharamacy = pharamacy else { return  }
        handleCheckedIndex?(pharamacy)
    }
    
}
