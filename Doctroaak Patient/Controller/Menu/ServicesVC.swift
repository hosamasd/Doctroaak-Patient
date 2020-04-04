//
//  ServicesVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ServicesVC: CustomBaseViewVC {
    
    lazy var customMainServicesView:CustomMainServicesView = {
        let v = CustomMainServicesView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.main1View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenVC)))
        v.main2View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenVC)))
        v.main3View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpen2VC)))
        v.main4View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpen3VC)))
        v.main5View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpen4VC)))
        v.main6View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpen5VC)))
        v.main7View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpen6VC)))


        return v
    }()
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1000)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    var index:Int? = 0
    
    
    
    
    //MARK: -user methods
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {

        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubview(customMainServicesView)
        customMainServicesView.fillSuperview()
        
    }
    
    func goToNextVC(vc:CustomBaseViewVC,indexx:Int)  {
//        vc.index = indexx
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //TODO:-Hnadle methods
    
  @objc  func handleOpenVC()  {
    let doc = DoctorListsVC()
    navigationController?.pushViewController(doc, animated: true)
    
    }
 
    
    @objc  func handleOpen2VC()  {
       let phar = PharmacyLocationVC()
       navigationController?.pushViewController(phar, animated: true)
       
       }
    
    @objc  func handleOpen3VC()  {
       let lab = LapSearchVC(index: 0)
       navigationController?.pushViewController(lab, animated: true)
       
       }
    
    @objc  func handleOpen4VC()  {
       let lab = LapSearchVC(index: 1) //for Rediology
            navigationController?.pushViewController(lab, animated: true)
       
       }
    
    @objc  func handleOpen5VC()  {
       let doc = IncubationSearchVC()
       navigationController?.pushViewController(doc, animated: true)
       
       }

    
    @objc  func handleOpen6VC()  {
    let doc = ICUSearchVC()
    navigationController?.pushViewController(doc, animated: true)
    
    }
    
   @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }

}
