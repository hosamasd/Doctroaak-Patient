//
//  Extensions.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import MOLH
extension UIView {
    
    func getCityFromIndex(_ index:Int) -> String {
        var citName = [String]()
        var cityId = [Int]()
        
        if MOLHLanguage.isRTLLanguage() {
            
        
        
        if let  cityArray = userDefaults.value(forKey: UserDefaultsConstants.cityNameARArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int]{
            
            citName = cityArray
            cityId = cityIds
            
            
            
            }}else {
            if let cityArray = userDefaults.value(forKey: UserDefaultsConstants.cityNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int] {
                citName = cityArray
                cityId = cityIds
            }
        }
        let ss = cityId.filter{$0 == index}
        let ff = ss.first ?? 1
        
        return citName[ff - 1 ]
    }
    
    func getAreaFromIndex(_ index:Int) -> String {
        var citName = [String]()
        var cityId = [Int]()
        if MOLHLanguage.isRTLLanguage() {

        if let  cityArray = userDefaults.value(forKey: UserDefaultsConstants.areaNameARArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int]{
            
            citName = cityArray
            cityId = cityIds
            
            
            
            }}else {
            if let cityArray = userDefaults.value(forKey: UserDefaultsConstants.areaNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int] {
                citName = cityArray
                cityId = cityIds
            }
        }
        let ss = cityId.filter{$0 == index}
        let ff = ss.first ?? 1
        return citName[ff-1]
    }
    
    func createMainButtonsForGender(title:String,img:UIImage,bg:Bool?,selector:Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        if (bg == true) {
            button.backgroundColor = ColorConstants.disabledButtonsGray
        }else{}
        
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        if MOLHLanguage.isRTLLanguage() {
            button.rightImage(image: img, renderMode: .alwaysOriginal)
        }else {
            button.leftImage(image: img, renderMode: .alwaysOriginal)
        }
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
        
    }
    
    func createMainButtonsForGenderss(title:String,img:UIImage,bg:Bool?) -> UIButton {
           let button = UIButton(type: .system)
           button.setTitle(title, for: .normal)
           button.setTitleColor(.black, for: .normal)
           if (bg == true) {
               button.backgroundColor = ColorConstants.disabledButtonsGray
           }else{}
           
           button.layer.cornerRadius = 8
           button.layer.borderWidth = 1
           button.layer.borderColor = UIColor.gray.cgColor
           button.clipsToBounds = true
           if MOLHLanguage.isRTLLanguage() {
               button.rightImage(image: img, renderMode: .alwaysOriginal)
           }else {
               button.leftImage(image: img, renderMode: .alwaysOriginal)
           }
           return button
           
       }
    
    func putAttributedText(la:UILabel,ft:String,st:String)  {
        let attributeText = NSMutableAttributedString(string: ft, attributes:  [.font : UIFont.boldSystemFont(ofSize: 18),.foregroundColor:UIColor.black])
           attributeText.append(NSAttributedString(string: st, attributes: [.font : UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor.lightGray]))
           la.attributedText = attributeText
       }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
    func makeMainSubViewWithAppendView(vv:[UIView]) ->UIView {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.constrainHeight(constant: 60)
        vv.forEach { (v) in
            l.addSubViews(views: v)
        }
        return l
    }
    
    func createMain2Buttons(title:String,color:UIColor,tags : Int? = 0) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.constrainHeight(constant: 50)
        button.tag = tags ?? 0
        button.layer.cornerRadius = 16
        button.backgroundColor = #colorLiteral(red: 0.9214958549, green: 0.9216470122, blue: 0.9214636683, alpha: 1)
        //        button.clipsToBounds =
        //        button.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        return button
    }
    
    func applyGradients(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        //        gradientLayer.cornerRadius = self.frame.height/2
        
        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func addGradientInSenderAndRemoveOther(sender:UIButton,index:Int? = 0,lef:UIColor? = #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1),right:UIColor? = #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1))  {
        
        let leftColor = lef?.cgColor ?? #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1).cgColor
        let rightColor = right?.cgColor ?? #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1).cgColor
        sender.applyGradient(colors: [leftColor,rightColor], index: 0)
    }
    
    func createMainTextFields(padding:CGFloat? = 16,place:String,type:UIKeyboardType? = .emailAddress,secre:Bool? = false) -> UITextField {
        let t = CustomSkyTextFieldRightPadding(padding: padding ?? 16, height: 50)
        t.layer.cornerRadius = 8
        t.clipsToBounds = true
        t.placeholder = place
        t.keyboardType = type ?? .emailAddress
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.lightGray.cgColor
        t.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: t.frame.height))
        t.leftViewMode = .always
        t.isSecureTextEntry = secre ?? false
        return t
    }
    
    func createMainTextFieldssss(padding:CGFloat? = 16,place:String,type:UIKeyboardType? = .emailAddress,secre:Bool? = false) -> UITextField {
        let t = CustomPaddingTextField()//CustomSkyTextFieldRightPadding(padding: padding ?? 16, height: 50)
        t.layer.cornerRadius = 8
        t.clipsToBounds = true
        t.placeholder = place
        t.keyboardType = type ?? .emailAddress
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.lightGray.cgColor
        t.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: t.frame.height))
        t.leftViewMode = .always
        t.isSecureTextEntry = secre ?? false
        return t
    }
    
    func createMainTextFieldsWithoutPods(place:String) -> UITextField {
        let t = UITextField()
        t.textAlignment = .center
        t.constrainHeight(constant: 50)
        t.layer.cornerRadius = 8
        t.clipsToBounds = true
        t.placeholder = place
        t.keyboardType = .default
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.lightGray.cgColor
        //        t.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: t.frame.height))
        //        t.leftViewMode = .always
        //        t.isSecureTextEntry = secre ?? false
        return t
    }
    
    func changeButtonState(enable:Bool,vv:UIButton)  {
        
        
        if enable {
            if vv.backgroundColor != nil {
                vv.applyGradient(colors: [ColorConstants.firstColorBangsegy,ColorConstants.secondColorBangsegy], index: 0)
                vv.setTitleColor(.black, for: .normal)
                vv.isEnabled = true
            }
            
        }else {
            if vv.backgroundColor == nil {
                removeSublayer(vv, layerIndex: 0)
                vv.backgroundColor =  ColorConstants.disabledButtonsGray
                vv.setTitleColor(.black, for: .normal)
                vv.isEnabled = false
            }else {
                vv.setTitleColor(.black, for: .normal)
                vv.backgroundColor =  ColorConstants.disabledButtonsGray
                vv.isEnabled = false
            }
        }
    }
    
    func addGradientInSenderAndRemoveOther(sender:UIButton,vv:UIButton)  {
        
        let leftColor = #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1).cgColor
        let rightColor = #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1).cgColor
        sender.applyGradient(colors: [leftColor,rightColor], index: 0)
        
        vv.setTitleColor(.black, for: .normal)
        removeSublayer(vv, layerIndex:  0)
        vv.backgroundColor = ColorConstants.disabledButtonsGray
    }
    
    // SWIFT 4 update
    func removeSublayer(_ view: UIView, layerIndex index: Int) {
        guard let sublayers = view.layer.sublayers else {
            print("The view does not have any sublayers.")
            return
        }
        if sublayers.count > index {
            view.layer.sublayers!.remove(at: index)
            
        } else {
            print("There are not enough sublayers to remove that index.")
        }
    }
    
    //    func createHoursTextFields() -> UITextField {
    //        let t = UITextField()
    //        t.textAlignment = .center
    //        t.layer.borderWidth = 1
    //        t.layer.backgroundColor = UIColor.gray.cgColor
    //        t.layer.cornerRadius = 16
    //        t.clipsToBounds = true
    //        t.textColor = .black
    //        t.backgroundColor = .white
    //        t.text = "00:00"
    //        t.constrainHeight(constant: 50)
    //        return t
    //    }
    
    
}


extension NSMutableAttributedString {
    
    @discardableResult func appendWith(color: UIColor = UIColor.darkText, weight: UIFont.Weight = .regular, ofSize: CGFloat = 12.0, _ text: String) -> NSMutableAttributedString{
        let attrText = NSAttributedString.makeWith(color: color, weight: weight, ofSize:ofSize, text)
        self.append(attrText)
        return self
    }
    
}
extension NSAttributedString {
    
    public static func makeWith(color: UIColor = UIColor.darkText, weight: UIFont.Weight = .regular, ofSize: CGFloat = 12.0, _ text: String) -> NSMutableAttributedString {
        
        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: ofSize, weight: weight), NSAttributedString.Key.foregroundColor: color]
        return NSMutableAttributedString(string: text, attributes:attrs)
    }
}



extension UIScrollView {
    
    func resizeScrollViewContentSize() {
        
        var contentRect = CGRect.zero
        
        for view in self.subviews {
            
            contentRect = contentRect.union(view.frame)
            
        }
        
        self.contentSize = contentRect.size
        
    }
    
}

extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}

extension NSTextAlignment {
    func rightOrLeft() -> NSTextAlignment {
        return MOLHLanguage.isRTLLanguage() ? .right : .left
    }
}
