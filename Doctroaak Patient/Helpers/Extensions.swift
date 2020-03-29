//
//  Extensions.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
extension UIView {
    
    
    func createMainButtons(title:String,color:UIColor,tags : Int? = 0) -> UIButton {
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
    
    func addGradientInSenderAndRemoveOther(sender:UIButton,index:Int? = 0)  {
        
        let leftColor = #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1).cgColor
        let rightColor = #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1).cgColor
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
