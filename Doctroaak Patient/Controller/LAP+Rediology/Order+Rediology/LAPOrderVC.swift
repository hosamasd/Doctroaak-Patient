//
//  LAPOrderVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LAPOrderVC: CustomBaseViewVC {
    
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
                v.constrainHeight(constant:  1000 )
        v.translatesAutoresizingMaskIntoConstraints = false
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customLAPOrderView:CustomLAPOrderView = {
        let v = CustomLAPOrderView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
//        v.orderSegmentedView.addTarget(self, action: #selector(handleOpenOther), for: .valueChanged)
        return v
    }()
    var bubleViewHeightConstraint:NSLayoutConstraint!
    
    var isDataFound = false
    
    fileprivate let index:Int!
    init(index:Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func setupViews() {
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customLAPOrderView)
        customLAPOrderView.fillSuperview()
    }
    
    func makeTheseChanges(hide:Bool,height:CGFloat,all:Bool? = true)  {
        DispatchQueue.main.async {
            
            if all ?? true {
                
                
                [self.customLAPOrderView.mainDropView,self.customLAPOrderView.addLapCollectionVC.view].forEach({$0.isHide(hide)})
                [self.customLAPOrderView.centerImage,self.customLAPOrderView.uploadView].forEach({$0.isHide(!hide)})
                self.customLAPOrderView.orLabel.isHide(true)
            }else {
                [self.customLAPOrderView.mainDropView,self.customLAPOrderView.addLapCollectionVC.view,self.customLAPOrderView.orLabel,self.customLAPOrderView.centerImage,self.customLAPOrderView.uploadView].forEach({$0.isHide(false)})
            }
            self.bubleViewHeightConstraint.constant = height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleOpenOther(sender:UISegmentedControl)  {
        switch sender.selectedSegmentIndex {
        case 0:
            makeTheseChanges(  hide: true, height: 800)
        case 1:
            self.customLAPOrderView.addLapCollectionVC.medicineArray.count > 0 ?  makeTheseChanges( hide: false, height: 1200) : makeTheseChanges( hide: false, height: 800)
        default:
            self.customLAPOrderView.addLapCollectionVC.medicineArray.count > 0 ?  makeTheseChanges( hide: false, height: 1200,all: false) : makeTheseChanges( hide: false, height: 1000,all: false)
        }
    }
}

