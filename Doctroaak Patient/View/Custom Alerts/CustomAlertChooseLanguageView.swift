//
//  CustomAlertChooseLanguageView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/6/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class CustomAlertChooseLanguageView: CustomBaseView {
    
    lazy var languageLabel = UILabel(text: "Choose Language".localized, font: .systemFont(ofSize: 16), textColor: .black)

    lazy var englishButton = cretaeButtonss(title: "English".localized,tags: 0)
    lazy var arabicButton = cretaeButtonss(title: "Arabic".localized,tags: 1)
    lazy var cancelButton = cretaeButtonss(title: "Cancel".localized,tags: 2)

    
    override func setupViews() {
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        let ss = stack(englishButton,arabicButton,cancelButton,spacing:8)
        
        stack(languageLabel,ss).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    func cretaeButtonss(title:String,tags:Int) -> UIButton {
        let  b = UIButton()
        b.setTitle(title, for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.tag = tags
        return b
    }
}
