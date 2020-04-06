//
//  CustomLapSearchView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import iOSDropDown
import TTSegmentedControl

class CustomLapSearchView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var titleLabel = UILabel(text: "Search ", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Select Your Location", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var searchSegmentedView:TTSegmentedControl = {
        let view = TTSegmentedControl()
        view.itemTitles = ["Search by city and area","Search by address"]
        view.allowChangeThumbWidth = false
        view.constrainHeight(constant: 50)
        view.thumbGradientColors = [#colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1),#colorLiteral(red: 0.5526981354, green: 0.3201900423, blue: 1, alpha: 1)]
        view.useShadow = true
        view.didSelectItemWith = {[unowned self] (index, title) in
            index == 0 ?    self.openTheseViewsOrHide(isVale: false) : self.openTheseViewsOrHide(isVale: true)
            self.lAPSearchViewModel.isFirstOpetion = index == 0 ? true : false
        }
        return view
    }()
    
    //    lazy var searchSegmentedView:UISegmentedControl = {
    //        let view = UISegmentedControl(items: ["Search by city and area","Search by address"])
    //        view.layer.cornerRadius = 16
    //        layer.masksToBounds = true
    //        view.clipsToBounds = true
    //        view.apportionsSegmentWidthsByContent = true
    //        view.layer.borderWidth = 1
    //        view.layer.backgroundColor = UIColor.lightGray.cgColor
    //        view.constrainHeight(constant: 50)
    //        view.selectedSegmentIndex = 0
    //        view.tintColor = .black
    //        view.backgroundColor = .white
    //        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 20)
    //        /// Gradient
    //        let gradient = CAGradientLayer()
    //        gradient.frame =  CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.width - 40, height: 20)
    //        let leftColor = #colorLiteral(red: 0.6002450585, green: 0.3833707869, blue: 0.9996971488, alpha: 1)
    //        let rightColor = #colorLiteral(red: 0.4903785586, green: 0.2679489255, blue: 0.9277817607, alpha: 1)
    //        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
    //        gradient.startPoint = CGPoint(x: 0, y: 0.5)
    //        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    //        /// Create gradient image
    //        UIGraphicsBeginImageContext(gradient.frame.size)
    //        gradient.render(in: UIGraphicsGetCurrentContext()!)
    //        let segmentedControlImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //
    //        // Normal Image
    //        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
    //        UIGraphicsBeginImageContext(rect.size);
    //        let context:CGContext = UIGraphicsGetCurrentContext()!;
    //        context.setFillColor(#colorLiteral(red: 0.9352307916, green: 0.9353840947, blue: 0.9351981282, alpha: 1).cgColor)
    //        context.fill(rect)
    //        let normalImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    //        UIGraphicsEndImageContext()
    //        /// Set segmentedControl image
    //        view.setBackgroundImage(normalImage, for: .normal, barMetrics: .default)
    //        view.setBackgroundImage(segmentedControlImage, for: .selected, barMetrics: .default)
    //        view.addTarget(self, action: #selector(handleOpenOther), for: .valueChanged)
    //        return view
    //    }()
    lazy var addressMainView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [addressImage,addressLabel])
        v.isHide(true)
        //        v.addSubViews(views: addressImage,addressLabel)
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenLocation)))
        
        v.hstack(addressLabel,addressImage).withMargins(.init(top: 4, left: 16, bottom: 4, right: 0))
        return v
    }()
    lazy var addressLabel = UILabel(text: "Address", font: .systemFont(ofSize: 16), textColor: .lightGray)
    lazy var addressImage:UIImageView = {
        let v = UIImageView(image: #imageLiteral(resourceName: "Group 4174"))
        v.isUserInteractionEnabled = true
        v.contentMode = .scaleAspectFill
        v.constrainWidth(constant: 60)
        
        return v
    }()
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [nameDrop])
    lazy var nameDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        i.placeholder = "Name".localized
        i.didSelect {[unowned self] (txt, index, _) in
            self.lAPSearchViewModel.name = txt
        }
        
        return i
    }()
    lazy var orLabel = UILabel(text: "OR", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    lazy var mainDrop2View = makeMainSubViewWithAppendView(vv: [cityDrop])
    lazy var cityDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        i.placeholder = "City".localized
        i.didSelect {[unowned self] (txt, index, _) in
            self.lAPSearchViewModel.city = txt
        }
        
        return i
    }()
    lazy var mainDrop3View = makeMainSubViewWithAppendView(vv: [areaDrop])
    lazy var areaDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        i.placeholder = "Area".localized
        i.didSelect {[unowned self] (txt, index, _) in
            self.lAPSearchViewModel.area = txt
        }
        return i
    }()
    
    lazy var insuranceView = makeMainSubViewWithAppendView(vv: [insuranceLabel,insuranceSwitch])
    
    lazy var insuranceLabel = UILabel(text: "Insurance company", font: .systemFont(ofSize: 20), textColor: .lightGray)
    
    lazy var insuranceSwitch:UISwitch = {
        let s = UISwitch()
        s.onTintColor = #colorLiteral(red: 0.3896943331, green: 0, blue: 0.8117204905, alpha: 1)
        s.isOn = true
        s.addTarget(self, action: #selector(handleInsuracneCheck), for: .valueChanged)
        return s
    }()
    lazy var delvieryView = makeMainSubViewWithAppendView(vv: [delvieryLabel,delvierySwitch])
    
    lazy var delvieryLabel = UILabel(text: "Delivery ?", font: .systemFont(ofSize: 20), textColor: .lightGray)
    lazy var delvierySwitch:UISwitch = {
        let s = UISwitch()
        s.onTintColor = #colorLiteral(red: 0.3896943331, green: 0, blue: 0.8117204905, alpha: 1)
        s.isOn = true
        s.addTarget(self, action: #selector(handleDelvieryCheck), for: .valueChanged)
        
        return s
    }()
    
    
    lazy var searchButton:UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    var handlerChooseLocation:(()->Void)?
    
    let lAPSearchViewModel = LAPSearchViewModel()
    
    
    override func setupViews() {
        let textStack = getStack(views: addressMainView,mainDropView,orLabel,mainDrop2View,mainDrop3View,insuranceView,delvieryView, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,searchSegmentedView,textStack,searchButton)
        mainDropView.hstack(nameDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        mainDrop2View.hstack(cityDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        mainDrop3View.hstack(areaDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        insuranceView.hstack(insuranceLabel,insuranceSwitch).withMargins(.init(top: 16, left: 16, bottom: 8, right: 16))
        delvieryView.hstack(delvieryLabel,delvierySwitch).withMargins(.init(top: 16, left: 16, bottom: 8, right: 16))
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        
        
        
        searchSegmentedView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 108, left: 46, bottom: 0, right: 32))
        textStack.anchor(top: searchSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 46, bottom: 0, right: 32))
        searchButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        
    }
    
    
    func openTheseViewsOrHide(isVale:Bool)  {
        [mainDropView,mainDrop2View,mainDrop3View,orLabel].forEach({$0.isHide(isVale)})
        addressMainView.isHide(!isVale)
    }
    
    
    @objc  func handleDelvieryCheck(sender:UISwitch)  {
        lAPSearchViewModel.delivery = sender.isOn
    }
    
    @objc  func handleInsuracneCheck(sender:UISwitch)  {
        lAPSearchViewModel.insuranceCompany = sender.isOn
    }
    
    @objc  func handleOpenLocation()  {
        handlerChooseLocation?()
    }
    
}

