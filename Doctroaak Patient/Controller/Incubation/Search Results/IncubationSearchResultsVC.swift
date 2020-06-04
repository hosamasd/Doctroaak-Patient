//
//  IncubationSearchResultsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class IncubationSearchResultsVC: CustomBaseViewVC {
    
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
    lazy var customIncubationResultsView:CustomIncubationResultsView = {
        let v = CustomIncubationResultsView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        return v
    }()
    
    var incubationArray:[IncubtionSearchModel]? {
        didSet {
            guard let incubationArray = incubationArray else { return  }
            customIncubationResultsView.incubationResultsCollectionVC.incubationArray=incubationArray
            DispatchQueue.main.async {
                self.customIncubationResultsView.incubationResultsCollectionVC.collectionView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
    }
    
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customIncubationResultsView)
        customIncubationResultsView.fillSuperview()
    }
    
  @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
}
