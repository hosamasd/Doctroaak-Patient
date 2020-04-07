//
//  CustomLAPOrderView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import iOSDropDown
import TTSegmentedControl

class CustomLAPOrderView: CustomBaseView {
    
    
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
    lazy var titleLabel = UILabel(text: "Order ", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Order your request", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var orderSegmentedView:TTSegmentedControl = {
        let view = TTSegmentedControl()
        view.itemTitles = ["prescription","Request a medicine","All"]
        
        view.allowChangeThumbWidth = true
        view.constrainHeight(constant: 50)
        view.thumbGradientColors = [#colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1),#colorLiteral(red: 0.5526981354, green: 0.3201900423, blue: 1, alpha: 1)]
        view.useShadow = true
        return view
    }()
    
    //    lazy var orderSegmentedView:UISegmentedControl = {
    //        let view = UISegmentedControl(items: ["prescription"," Analysis name","All"])
    //        view.translatesAutoresizingMaskIntoConstraints = false
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
    //                view.addTarget(self, action: #selector(handleOpenOther), for: .valueChanged)
    //        return view
    //    }()
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
    lazy var uploadLabel = UILabel(text: "Upload prescription", font: .systemFont(ofSize: 20), textColor: .lightGray,textAlignment: .center)
    
    lazy var uploadImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4174"))
        i.constrainWidth(constant: 80)
        return i
    }()
    lazy var orLabel = UILabel(text: "OR", font: .systemFont(ofSize: 18), textColor: .black,textAlignment: .center)
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [nameDrop])
    lazy var nameDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        i.placeholder = "Name".localized
        i.didSelect {[unowned self] (txt, index, _) in
            self.laPOrderViewModel.name = txt
        }
        return i
    }()
    lazy var addLapCollectionVC:AddLapCollectionVC = {
        let vc = AddLapCollectionVC()
        //        vc.view.constrainHeight(constant: 300)
//        vc.view.isHide(true)
        return vc
    }()
    lazy var addMoreImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4178"))
        i.isUserInteractionEnabled = true
        i.constrainWidth(constant: 60)
        i.constrainHeight(constant: 60)
        i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddMore)))

        return i
    }()
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    var constainedLogoAnchor:AnchoredConstraints!
    var bubleViewBottomTitleConstraint:NSLayoutConstraint!
    var bubleViewCenterImgHeightConstraint:NSLayoutConstraint!
    var bubleViewTopSegConstraint:NSLayoutConstraint!
    
    var isDataFound = false
    var isSecondIndex = false
    
    let laPOrderViewModel = LAPOrderViewModel()
    
    
    override func setupViews() {
        bubleViewCenterImgHeightConstraint = centerImage.heightAnchor.constraint(equalToConstant: 250)
        bubleViewCenterImgHeightConstraint.isActive = true
        [titleLabel,orderSegmentedView,LogoImage].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        [orLabel,addMoreImage,mainDropView].forEach({$0.isHide(true)})
        
        let dd = getStack(views: UIView(),addMoreImage, spacing: 16, distribution: .fill, axis: .horizontal)
        
        
        let mainStack =  getStack(views: rosetaImageView,centerImage,uploadView,orLabel,mainDropView,dd,addLapCollectionVC.view,UIView(), spacing: 16, distribution: .fill, axis: .vertical)
        mainDropView.hstack(nameDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        uploadView.hstack(uploadImage,uploadLabel)
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,orderSegmentedView,mainStack,nextButton)
        
        
        constainedLogoAnchor = LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        
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
        
        if all ?? true {
            
            
            [self.mainDropView,addMoreImage].forEach({$0.isHide(hide)})
            [self.centerImage,self.uploadView].forEach({$0.isHide(!hide)})
            self.orLabel.isHide(true)
        }else {
            [self.mainDropView,self.orLabel,self.centerImage,self.uploadView,addMoreImage].forEach({$0.isHide(false)})
        }
//        addLapCollectionVC.view.isHide(  addLapCollectionVC.medicineArray.count > 0 ? false : true )
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
    
    @objc func handleOpenOther(sender:UISegmentedControl)  {
        switch sender.selectedSegmentIndex {
        case 0:
            makeTheseChanges(  hide: true, height: 800)
            updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116"),tr: 0,tops: 186,bottomt:80,log: -48 ,centerImg: 250)
            addLapCollectionVC.view.isHide(true)
        case 1:
            self.addLapCollectionVC.medicineArray.count > 0 ?  makeTheseChanges( hide: false, height: 1200) : makeTheseChanges( hide: false, height: 800)
            updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116"),tr: 0,tops: 186,bottomt:80,log: -48, centerImg: 100 )
        default:
            self.addLapCollectionVC.medicineArray.count > 0 ?  makeTheseChanges( hide: false, height: 1200,all: false) : makeTheseChanges( hide: false, height: 1000,all: false)
            updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116-1"),tr: 60,tops: 80,bottomt:0,log: 0, centerImg: 100 )
        }
    }
    
    @objc  func handleAddMore()  {
       guard let name = laPOrderViewModel.name else {print("all fields required"); return  }
//       let model = MedicineModel(name: name, type: type, count: count)
        addLapCollectionVC.medicineArray.append(name)
       DispatchQueue.main.async {
           self.addLapCollectionVC.collectionView.reloadData()
       }
       
       
       print(name)
       }
    
}


