//
//  CustomPharmacyOrderView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import TTSegmentedControl
import iOSDropDown
import MOLH

class CustomPharmacyOrderView: CustomBaseView {
    
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: MOLHLanguage.isRTLLanguage() ? #imageLiteral(resourceName: "left-arrow") : #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var titleLabel = UILabel(text: "Order ".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Order your request".localized, font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var orderSegmentedView:TTSegmentedControl = {
        let view = TTSegmentedControl()
        view.itemTitles = ["prescription".localized,"Request a medicine".localized,"All".localized]
        view.constrainHeight(constant: 50)
        view.thumbGradientColors = [#colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1),#colorLiteral(red: 0.5526981354, green: 0.3201900423, blue: 1, alpha: 1)]
        view.useShadow = true
        view.allowChangeThumbWidth = true
        
        return view
    }()
    
    lazy var centerImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "2454170"))
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    lazy var rosetaImageView:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "G4-G5 Sample Rx"))
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.isHide(true)
        return i
    }()
    lazy var uploadView = makeMainSubViewWithAppendView(vv: [uploadLabel,uploadImage])
    lazy var uploadLabel = UILabel(text: "Upload prescription".localized, font: .systemFont(ofSize: 20), textColor: .lightGray,textAlignment: .center)
    
    lazy var uploadImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4174"))
        i.constrainWidth(constant: 80)
        return i
    }()
    lazy var orLabel = UILabel(text: "OR", font: .systemFont(ofSize: 18), textColor: .black,textAlignment: .center)
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [nameDrop])
    lazy var nameDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
        i.arrowSize = 20
        i.textColor = .black
        i.rowBackgroundColor = .gray
        
        i.placeholder = "Name".localized
        i.didSelect {[unowned self] (txt, index, _) in
            //            self.selectedName=self.pha
            //            self.pharamacyOrderViewModel.name = txt
        }
        return i
    }()
    lazy var main2DropView = makeMainSubViewWithAppendView(vv: [typeDrop])
    lazy var textView:UITextView = {
        let tx = UITextView()
        tx.isScrollEnabled = false
        tx.font = UIFont.systemFont(ofSize: 16)
        tx.delegate = self
        //        tx.sizeToFit()
        return tx
    }()
    lazy var placeHolderLabel = UILabel(text: "Enter Text (Optional)".localized, font: .systemFont(ofSize: 16), textColor: .lightGray,textAlignment: .left )
    lazy var  mainView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [textView,placeHolderLabel])
        //        v.constrainHeight(constant: 120)
        //        v.hstack(placeHolderLabel)
        //        v.hstack(textView)
        v.isHide(true)
        return v
    } ()
    
    lazy var typeDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
        i.arrowSize = 20
        i.textColor = .black
        i.rowBackgroundColor = .gray
        
        i.placeholder = "Type".localized
        i.didSelect {[unowned self] (txt, index, _) in
            self.pharamacyOrderViewModel.api_token = txt
        }
        return i
    }()
    lazy var quantityLabel = UILabel(text: "Quantity".localized, font: .systemFont(ofSize: 16), textColor: .black)
    lazy var customAddMinusView:CustomAddMinusView = {
        let v = CustomAddMinusView()
        v.handleAddClousre = {[unowned self] count in
            //            self.pharamacyOrderViewModel.quantity = "\(count)"
        }
        v.handleMinusClousre = {[unowned self] count in
            //            self.pharamacyOrderViewModel.quantity = "\(count)"
        }
        return v
    } ()
    
    lazy var addMedicineCollectionVC:AddMedicineCollectionVC = {
        let vc = AddMedicineCollectionVC()
        return vc
    }()
    lazy var addMoreImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4178"))
        i.isUserInteractionEnabled = true
        i.constrainWidth(constant: 60)
        i.constrainHeight(constant: 60)
        i.isUserInteractionEnabled = true
        i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddMore)))
        return i
    }()
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("Next".localized, for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    let pharamacyOrderViewModel = PharamacyOrderViewModel()
    var  latt:Double?
    var  long:Double?
    var  api_token:String?
    var  patient_id:Int?
    var  insurance:Int?
    var  delivery:Int?
    var selectedName:Int = 1
    var selectedTypee:String = ""
    var selectedCount:Int = 1
    
    var constainedLogoAnchor:AnchoredConstraints!
    var bubleViewBottomTitleConstraint:NSLayoutConstraint!
    var bubleViewCenterImgHeightConstraint:NSLayoutConstraint!
    var bubleViewTopSegConstraint:NSLayoutConstraint!
    
    var isDataFound = false
    var isSecondIndex = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChanged), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setupViews() {
        [titleLabel,soonLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        
        bubleViewCenterImgHeightConstraint = centerImage.heightAnchor.constraint(equalToConstant: 250)
        bubleViewCenterImgHeightConstraint.isActive = true
        [titleLabel,orderSegmentedView,LogoImage].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        [orLabel,addMoreImage,mainDropView,main2DropView,customAddMinusView,quantityLabel].forEach({$0.isHide(true)})
        
        let dd = getStack(views: UIView(),addMoreImage, spacing: 16, distribution: .fill, axis: .horizontal)
        let ff = getStack(views: quantityLabel,customAddMinusView, spacing: 8, distribution: .fillProportionally, axis: .horizontal)
        textView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        placeHolderLabel.fillSuperview(padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        
        let mainStack =  getStack(views: rosetaImageView,centerImage,uploadView,orLabel,mainDropView,main2DropView,ff,dd,mainView,addMedicineCollectionVC.view,UIView(), spacing: 16, distribution: .fill, axis: .vertical)
        mainDropView.hstack(nameDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        main2DropView.hstack(typeDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        
        uploadView.hstack(uploadImage,uploadLabel)
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,orderSegmentedView,mainStack,nextButton)
        
        
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
        //        constainedLogoAnchor = LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        
        //        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: -30, left: 0, bottom: 0, right: -60))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: backImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -80, right: 0))
        bubleViewBottomTitleConstraint = titleLabel.bottomAnchor.constraint(equalTo: backImage.bottomAnchor, constant: 80)
        bubleViewBottomTitleConstraint.isActive = true
        
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        orderSegmentedView.anchor(top: backImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 186, left: 32, bottom: 16, right: 32))
        bubleViewTopSegConstraint = orderSegmentedView.topAnchor.constraint(equalTo: backImage.bottomAnchor, constant: 186)
        bubleViewTopSegConstraint.isActive = true
        
        mainStack.anchor(top: orderSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nextButton.topAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 46, bottom: 32, right: 32))
        
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    
    
    func makeTheseChanges(hide:Bool,height:CGFloat,all:Bool? = true)  {
        //        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
        
        if all ?? true {
            
            
            [self.mainDropView,self.addMoreImage,self.main2DropView,self.customAddMinusView,self.quantityLabel].forEach({$0.isHide(hide)})
            [self.centerImage,self.uploadView].forEach({$0.isHide(!hide)})
            self.orLabel.isHide(true)
        }else {
            [self.mainDropView,self.orLabel,self.centerImage,self.uploadView,addMoreImage].forEach({$0.isHide(false)})
            
        }
    }
    
    func updateOtherLabels(img:UIImage,tr:CGFloat,tops:CGFloat,bottomt:CGFloat,log:CGFloat,centerImg:CGFloat) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.LogoImage.image = img
            self.constainedLogoAnchor.trailing?.constant = tr
            self.constainedLogoAnchor.leading?.constant = log
            self.bubleViewBottomTitleConstraint.constant = bottomt
            self.bubleViewTopSegConstraint.constant = tops
            self.bubleViewCenterImgHeightConstraint.constant = centerImg
            
        })
    }
    
    @objc  func handleTextChanged()  {
        placeHolderLabel.isHidden = textView.text.count != 0
        
    }
    
    @objc  func handleAddMore()  {
        
        
        let type = PharamcyOrderModel(medicineID: 1, medicineTypeID: 1, amount: 1)
        DispatchQueue.main.async {
            self.addMedicineCollectionVC.view.isHide(false)
            self.addMedicineCollectionVC.collectionView.reloadData()
        }
    }
    
}




extension CustomPharmacyOrderView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        //        mainView.layer.borderColor = ColorConstant.mainBackgroundColor.cgColor
        guard let texts = textView.text else { return  }
        
        if  texts.count == 0 {
            pharamacyOrderViewModel.notes = nil
        }
        else {
            pharamacyOrderViewModel.notes = texts
        }
    }
}
