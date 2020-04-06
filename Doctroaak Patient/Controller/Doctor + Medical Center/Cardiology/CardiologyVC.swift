//
//  CardiologyVC.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CardiologyVC: UIViewController {
    
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
    lazy var customCardiologyView:CustomCardiologyView = {
        let v = CustomCardiologyView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))

        v.handleCheckedIndex = {[unowned self] indexPath in
            let cDetails = DeatilsVC()
            self.navigationController?.pushViewController(cDetails, animated: true)
        }
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
    }
    
    
    func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    func setupViews()  {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        //        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customCardiologyView)
        customCardiologyView.fillSuperview()
    }
    
    
    @objc  func handleBack()  {
          navigationController?.popViewController(animated: true)
      }
}
