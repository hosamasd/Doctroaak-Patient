//
//  PharamacySearchResultsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/1/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class PharamacySearchResultsVC: CustomBaseViewVC {
    
 lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 900)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customPharamacyResultsView:CustomPharamacyResultsView = {
        let v = CustomPharamacyResultsView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.handlePharamacyCheckedIndex = {[unowned self] indexx in
            
            let selected = PharmacyOrderVC()//LAPSelectedSearchResultsVC(index: self.index)
            selected.pharmacy_id=indexx.id
//            selected.apiToken=self.apiToken
//            selected.patientId=self.patientId
            self.navigationController?.pushViewController(selected, animated: true)
        }
        
        return v
    }()
    
    //    fileprivate let
    
    var pharamacyArrayResults:[PharamacySearchModel]?{
        didSet{
            guard let pharamacyArrayResults = pharamacyArrayResults else { return  }
            self.customPharamacyResultsView.pharamacyArrayResults=pharamacyArrayResults
        }
    }
    var apiToken:String?
    var patientId:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
    }
    
    //MARK:-User methods
    
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customPharamacyResultsView)
        customPharamacyResultsView.fillSuperview()
    }
    
    //TODO: -handle methods
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
}

