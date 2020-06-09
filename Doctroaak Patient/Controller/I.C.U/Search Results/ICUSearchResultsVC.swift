//
//  ICUSearchResultsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ICUSearchResultsVC: CustomBaseViewVC {
    
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
    lazy var customICUResultsView:CustomICUResultsView = {
        let v = CustomICUResultsView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.handleSelectedItem = {[unowned self] icu in
            let result = ICUSlelcetedResultVC( index:0 )
            result.icu=icu
            self.navigationController?.pushViewController(result, animated: true)
        }
        v.handleSecondSelectedItem = {[unowned self] icu in
            let result = ICUSlelcetedResultVC( index:0 )
            result.incubation=icu
            self.navigationController?.pushViewController(result, animated: true)
        }
        return v
    }()
    
    var icuArray: [ICUFilterModel]?{
        didSet{
            guard let icu = icuArray else { return  }
            customICUResultsView.icuResultsCollectionVC.icuArray=icu
            customICUResultsView.icuResultsCollectionVC.index=index
            DispatchQueue.main.async {
                self.customICUResultsView.icuResultsCollectionVC.collectionView.reloadData()
            }
         }
    }
    
    var icubationArray: [IncubtionSearchModel]?{
         didSet{
             guard let icu = icubationArray else { return  }
             customICUResultsView.icuResultsCollectionVC.icubationArray=icu
            customICUResultsView.icuResultsCollectionVC.index=index

             DispatchQueue.main.async {
                 self.customICUResultsView.icuResultsCollectionVC.collectionView.reloadData()
             }
          }
     }
    
    fileprivate let index:Int!
    init(index:Int) {
        self.index=index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        mainView.addSubViews(views: customICUResultsView)
        customICUResultsView.fillSuperview()
    }
    
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
}
