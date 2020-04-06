//
//  LapSearchResultsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LapSearchResultsVC: CustomBaseViewVC {
    
    lazy var customLapResultsView:CustomLapResultsView = {
        let v = CustomLapResultsView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))

        v.index = index
        v.handleCheckedIndex = {[unowned self] indexx in
            let selected = LAPSelectedSearchResultsVC(index: self.index)
            self.navigationController?.pushViewController(selected, animated: true)
            }

        return v
    }()
    
    fileprivate let index:Int!
    init(index:Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
   
    
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
        
        view.addSubViews(views: customLapResultsView)
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
