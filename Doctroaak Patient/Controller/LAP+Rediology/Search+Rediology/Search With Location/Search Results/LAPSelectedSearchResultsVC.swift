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

        return v
    }()
    
    fileprivate let index:Int!
    init(index:Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        
        view.addSubViews(views: customLAPSelectedSearchView)
        customLAPSelectedSearchView.fillSuperview()
    }
    
    @objc  func handleBack()  {
           navigationController?.popViewController(animated: true)
       }
    
   @objc func handleBook()  {
        let book = LAPBookVC(index:index)
           navigationController?.pushViewController(book, animated: true)
    }
    
}
