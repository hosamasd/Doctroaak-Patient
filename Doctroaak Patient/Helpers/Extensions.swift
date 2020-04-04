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
