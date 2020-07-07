//
//  AnimationsFactory.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/19/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import Foundation
import UIKit

class AnimationsFactory {
    enum animations {
        case pop(from: CGFloat)
        case shake
        case redBorder
        var animation: CAAnimation {
            switch self {
            case .pop(let from):
                return AnimationsFactory.pulseAnimation(from: from)
            case .shake:
                return AnimationsFactory.shakeAnimation()
            case .redBorder:
                return AnimationsFactory.redBorder()
            }
        }
    }
    
    static func addAnimation(_ view: UIView, animation: animations){
        view.layer.add(animation.animation, forKey: nil)
    }
    
    static func addAnimations(_ view: UIView, animations: [animations]){
        for animation in animations {
            view.layer.add(animation.animation, forKey: nil)
        }
    }
    
    static private func pulseAnimation(from: CGFloat) -> CASpringAnimation {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        //        let group = CAAnimationGroup()
        
        pulse.fromValue = from
        pulse.toValue = 1
        pulse.duration = 1.1
        pulse.timingFunction = CAMediaTimingFunction(name: .easeOut)
        pulse.repeatCount = 0
        return pulse
    }
    
    static private func shakeAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -2.0, 2.0, 0.0 ]

        return animation
    }
    
    static private func redBorder() -> CABasicAnimation {
        let color = CABasicAnimation(keyPath: "borderColor")
//        color.fromValue = UIColor.greenColor().CGColor
        color.toValue = UIColor.red.cgColor
        color.duration = 0.3
        color.repeatCount = 1
        color.autoreverses = true

        return color
    }
}
