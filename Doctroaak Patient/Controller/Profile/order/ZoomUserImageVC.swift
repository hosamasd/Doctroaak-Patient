//
//  ZoomUserImageVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/3/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ZoomUserImageVC: CustomBaseViewVC {
    
lazy var mainImageView:UIImageView = {
        let i = UIImageView(image: img)
        i.contentMode = .scaleAspectFill
        i.enableZoom()
        return i
    }()
    fileprivate let img:UIImage!
    
    init(img:UIImage) {
        self.img = img
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(false)
        let label = UILabel(text: "Preview".localized, font: .systemFont(ofSize: 20), textColor: .black)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_clear_24px").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleClose))
    }
    
   override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubViews(views: mainImageView)
        
        mainImageView.centerInSuperview(size: .init(width: view.frame.width, height: 250))
    }
    
    
    
    //
    @objc  func handleClose()  {
        navigationController?.popViewController(animated: true)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
