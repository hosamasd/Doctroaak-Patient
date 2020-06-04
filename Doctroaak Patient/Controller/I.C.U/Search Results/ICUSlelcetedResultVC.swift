//
//  ICUSlelcetedResultVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ICUSlelcetedResultVC: CustomBaseViewVC {
    
    lazy var customICUSelectedSearchView:CustomICUSelectedSearchView = {
        let v = CustomICUSelectedSearchView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showToast(message: "hksjfbnkjsdnf sdl,fnsldkfn", font: .systemFont(ofSize: 20))
        //        popUp(context: self, msg: "sdgsdvdsgv dsgvdsgvds")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func setupViews() {
        //        showToast(message: "hksjfbnkjsdnf sdl,fnsldkfn", font: .systemFont(ofSize: 20))
        
        view.addSubview(customICUSelectedSearchView)
        customICUSelectedSearchView.fillSuperview()
    }
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    
}
