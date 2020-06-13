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
        v.index = index
        return v
    }()
    
    var icu:ICUFilterModel? {
        didSet{
            guard let inc = icu else { return  }
            DispatchQueue.main.async {
                self.customICUSelectedSearchView.icuSelectedResultsCell.icu = inc
            }
        }
    }
    var incubation:IncubtionSearchModel?{
        didSet{
            guard let inc = incubation else { return  }
            DispatchQueue.main.async {
                self.customICUSelectedSearchView.icuSelectedResultsCell.icubation = inc
            }
        }
    }
    
    fileprivate let index:Int!
    
    init(index:Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    //TODO: -handle methods
    
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    
}
