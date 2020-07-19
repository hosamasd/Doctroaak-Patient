//
//  LapSearchResultsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LapSearchResultsVC: CustomBaseViewVC {
    
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
    lazy var customLapResultsView:CustomLapResultsView = {
        let v = CustomLapResultsView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.radiologyArrayResults = radiologyArrayResults
        v.labArrayResults=labArrayResults
        v.index = index
        v.handleLabCheckedIndex = {[unowned self] indexx in
            let selected = LAPSelectedSearchResultsVC(index: self.index)
            selected.patient=self.patient
            selected.labArrayResults=indexx
            self.navigationController?.pushViewController(selected, animated: true)
        }
        v.handleRdiologyCheckedIndex = {[unowned self] indexx in
            let selected = LAPSelectedSearchResultsVC(index: self.index)
            selected.patient=self.patient
            selected.radiologyArrayResults=indexx
            self.navigationController?.pushViewController(selected, animated: true)
        }
        
        return v
    }()
    
    
    var labArrayResults = [LapSearchModel]()
    var radiologyArrayResults = [RadiologySearchModel]()
    var patient:PatienModel? {
        didSet{
            guard let patient = patient else { return  }
        }
    }
    fileprivate let index:Int!
    init(index:Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
        scrollView.delegate=self
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
        mainView.addSubViews(views: customLapResultsView)
        customLapResultsView.fillSuperview()
    }
    
    //TODO: -handle methods
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension LapSearchResultsVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
