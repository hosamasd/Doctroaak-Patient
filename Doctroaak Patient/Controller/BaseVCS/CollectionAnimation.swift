//
//  CollectionAnimation.swift
//  TableAnimations
//
//  Created by Hossam on 7/7/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit


import UIKit

typealias collectionCellAnimation = (UICollectionViewCell, IndexPath, UICollectionView) -> Void

final class CollectionViewAnimator {
    private let animation: collectionCellAnimation
    
    init(animation: @escaping collectionCellAnimation) {
        self.animation = animation
    }
    
    func animate(cell: UICollectionViewCell, at indexPath: IndexPath, in collectionView: UICollectionView) {
        animation(cell, indexPath, collectionView)
    }
}

///enums providing tableViewCell animations
enum CollectionAnimationFactory {
    
    /// fades the cell by setting alpha as zero and then animates the cell's alpha based on indexPaths
    static func makeFadeAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> collectionCellAnimation {
        return { cell, indexPath, _ in
            cell.alpha = 0
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
        }
    }
    
    /// fades the cell by setting alpha as zero and moves the cell downwards, then animates the cell's alpha and returns it to it's original position based on indexPaths
    static func makeMoveUpWithFadeAnimation(rowHeight: CGFloat, duration: TimeInterval, delayFactor: TimeInterval) -> collectionCellAnimation {
        return { cell, indexPath, _ in
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight * 1.4)
            cell.alpha = 0
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.alpha = 1
            })
        }
    }
    
    /// moves the cell downwards, then animates the cell's by returning them to their original position based on indexPaths
    static func makeMoveUpAnimation(rowHeight: CGFloat, duration: TimeInterval, delayFactor: TimeInterval) -> collectionCellAnimation {
        return { cell, indexPath, _ in
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight * 1.4)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
    
    /// moves the cell downwards, then animates the cell's by returning them to their original position with spring bounce based on indexPaths
    static func makeMoveUpBounceAnimation(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> collectionCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.1,
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
}



enum CollectionAnimation{
    
    case fadeIn(duration: TimeInterval, delay: TimeInterval)
    case moveUp(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    case moveUpWithFade(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    case moveUpBounce(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    
    // provides an animation with duration and delay associated with the case
    func getAnimation() -> collectionCellAnimation {
        switch self {
        case .fadeIn(let duration, let delay):
            return CollectionAnimationFactory.makeFadeAnimation(duration: duration, delayFactor: delay)
        case .moveUp(let rowHeight, let duration, let delay):
            return CollectionAnimationFactory.makeMoveUpAnimation(rowHeight: rowHeight, duration: duration, delayFactor: delay)
        case .moveUpWithFade(let rowHeight, let duration, let delay):
            return CollectionAnimationFactory.makeMoveUpWithFadeAnimation(rowHeight: rowHeight, duration: duration, delayFactor: delay)
        case .moveUpBounce(let rowHeight, let duration, let delay):
            return CollectionAnimationFactory.makeMoveUpBounceAnimation(rowHeight: rowHeight, duration: duration, delayFactor: delay)
        }
    }
    
    // provides the title based on the case
    func getTitle() -> String {
        switch self {
        case .fadeIn(_, _):
            return "Fade-In Animation"
        case .moveUp(_, _, _):
            return "Move-Up Animation"
        case .moveUpWithFade(_, _, _):
            return "Move-Up-Fade Animation"
        case .moveUpBounce(_, _, _):
            return "Move-Up-Bounce Animation"
        }
    }
}

