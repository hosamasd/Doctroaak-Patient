//
//  LAPSelectedSearchResultsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/1/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LAPSelectedSearchResultsVC: CustomBaseViewVC {
    
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
    lazy var customLAPSelectedSearchView:CustomLAPSelectedSearchView = {
        let v = CustomLAPSelectedSearchView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.bookButton.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
        v.index = index
        return v
    }()
    
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
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customLAPSelectedSearchView)
        customLAPSelectedSearchView.fillSuperview()
    }
    
    //TODO: -handle methods
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleBook()  {
        let book = LAPBookVC(index:index)
        navigationController?.pushViewController(book, animated: true)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
