//
//  CustomAlertMainLoodingView.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/13/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import Lottie

class CustomAlertMainLoodingView: CustomBaseView {
    
    lazy var problemsView:AnimationView = {
        let i = AnimationView()
        return i
    }()
    
    override func setupViews() {
        backgroundColor = .clear
        stack(problemsView)
    }
    
    func setupAnimation(name:String)  {
        problemsView.animation = Animation.named(name)
        problemsView.play()
        problemsView.loopMode = .loop
    }
    
}
