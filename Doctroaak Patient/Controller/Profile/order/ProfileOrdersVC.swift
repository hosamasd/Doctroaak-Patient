//
//  ProfileOrdersVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ProfileOrdersVC: CustomBaseViewVC {
    
    //    lazy var scrollView: UIScrollView = {
    //        let v = UIScrollView()
    //        v.backgroundColor = .clear
    //        
    //        return v
    //    }()
    //    lazy var mainView:UIView = {
    //        let v = UIView(backgroundColor: .white)
    //        v.constrainHeight(constant: 900)
    //        v.constrainWidth(constant: view.frame.width)
    //        return v
    //    }()
    lazy var customProfileOrdersView:CustomProfileOrdersView = {
        let v = CustomProfileOrdersView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        v.handleCheckedIndex = {[unowned self] indexPath in
            let cDetails = DeatilsVC()
            self.navigationController?.pushViewController(cDetails, animated: true)
        }
        return v
    }()
    lazy var mainBottomView:UIView = {
        let v = UIView(backgroundColor: .red)
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDoctors)))
        
        //        v.addSubview(customBottomOrdersView)
        //        v.stack(customBottomOrdersView)
        return v
    }()
    lazy var customBottomOrdersView:CustomBottomOrdersView = {
        let v = CustomBottomOrdersView()
        v.firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDoctors)))
        v.secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePharamcys)))
        v.thirdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLabs)))
        v.forthView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRadiologys)))
        
        return v
    } ()
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        
        view.addSubViews(views: customProfileOrdersView,customBottomOrdersView)
        customProfileOrdersView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 50, right: 0))
        customBottomOrdersView.anchor(top: customProfileOrdersView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    func hideAndUnhide(v:UIView,vv:[UIView],img:UIImageView,otherImage:[UIImageView])  {
        
        DispatchQueue.main.async {
            v.isHide(false)
            img.image?.withRenderingMode(.alwaysTemplate)
            vv.forEach({$0.isHide(true)})
        }
        
    }
    
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDoctors()  {
        hideAndUnhide(v: customBottomOrdersView.doctorLabel, vv: [customBottomOrdersView.labLabel,customBottomOrdersView.radiologyLabel,customBottomOrdersView.pharamacyLabel], img: customBottomOrdersView.firstImage, otherImage: [customBottomOrdersView.secondImage,customBottomOrdersView.thirdImage,customBottomOrdersView.forthImage])
    }
    
    @objc func handlePharamcys()  {
        hideAndUnhide(v: customBottomOrdersView.pharamacyLabel, vv: [customBottomOrdersView.labLabel,customBottomOrdersView.radiologyLabel,customBottomOrdersView.doctorLabel], img: customBottomOrdersView.secondImage, otherImage: [customBottomOrdersView.firstImage,customBottomOrdersView.thirdImage,customBottomOrdersView.forthImage])
    }
    @objc func handleLabs()  {
        hideAndUnhide(v: customBottomOrdersView.labLabel, vv: [customBottomOrdersView.doctorLabel,customBottomOrdersView.radiologyLabel,customBottomOrdersView.pharamacyLabel], img: customBottomOrdersView.thirdImage, otherImage: [customBottomOrdersView.secondImage,customBottomOrdersView.firstImage,customBottomOrdersView.forthImage])
    }
    @objc func handleRadiologys()  {
        hideAndUnhide(v: customBottomOrdersView.radiologyLabel, vv: [customBottomOrdersView.labLabel,customBottomOrdersView.doctorLabel,customBottomOrdersView.pharamacyLabel], img: customBottomOrdersView.forthImage, otherImage: [customBottomOrdersView.secondImage,customBottomOrdersView.thirdImage,customBottomOrdersView.firstImage])
    }
    
}
