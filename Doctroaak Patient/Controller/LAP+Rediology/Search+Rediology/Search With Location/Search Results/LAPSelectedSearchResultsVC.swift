//
//  LAPSelectedSearchResultsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/1/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LAPSelectedSearchResultsVC: CustomBaseViewVC {
    
    lazy var customLAPSelectedSearchView:CustomLAPSelectedSearchView = {
        let v = CustomLAPSelectedSearchView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.bookButton.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
        v.index = index
        v.lab = labArrayResults
        v.rad=radiologyArrayResults
        v.handleGetLocation = {[unowned self] (la,lng) in
            let v = OpenLocationUsingLatAndLongView(lat: la, lng: lng)
            self.customMainAlertVC.addCustomViewInCenter(views: v, height: 200)
            self.present(self.customMainAlertVC, animated: true)
        }
        return v
    }()
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    var labArrayResults: LapSearchModel?
    var radiologyArrayResults :RadiologySearchModel?
    var apiToken:String?
       var patientId:Int?
    fileprivate let index:Int!
    init(index:Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:-User methods
    
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.addSubview(customLAPSelectedSearchView)
        customLAPSelectedSearchView.fillSuperview()
    }
    
    //TODO: -handle methods
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleBook()  {
        let labId:Int = index == 0 ? labArrayResults?.id ?? 0 : radiologyArrayResults?.id ?? 0
        
        
        let book = LAPOrderVC(index:index,lab:labId )
        book.patientId=patientId
        book.apiToken=apiToken
        navigationController?.pushViewController(book, animated: true)
    }
    
    @objc func handleDismiss()  {
        dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
