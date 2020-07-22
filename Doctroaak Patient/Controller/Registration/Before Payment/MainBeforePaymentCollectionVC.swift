//
//  MainBeforePaymentCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH

class MainBeforePaymentCollectionVC: BaseCollectionVC {
    
    var currentTableAnimation: CollectionAnimation = .fadeIn(duration: 0.25, delay: 0)

    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = #colorLiteral(red: 0.1985675395, green: 0.6542165279, blue: 0.5319386125, alpha: 1)
        pc.pageIndicatorTintColor = #colorLiteral(red: 0.8274509804, green: 0.8274509804, blue: 0.8274509804, alpha: 1)
        //                   pc.addTarget(self, action: #selector(pageControlSelectionAction(_:)), for: .touchUpInside)
        return pc
    }()
    
    lazy var nextButton = createButtons(img: #imageLiteral(resourceName: "buttons-square-green"), tags: 0, selector: #selector(handleNext))
    lazy var paymentButton:UIButton = {
        let b =  UIButton(title: "Payment".localized, titleColor: .white, font: .systemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0.4701498151, green: 0.200353235, blue: 0.998151958, alpha: 1), target: self, action: #selector(handlePayment))
        b.layer.cornerRadius = 8
        b.clipsToBounds = true
        b.constrainHeight(constant: 60)
        return b
    }()
    lazy var backButton = createButtons(img: #imageLiteral(resourceName: "buttons-square-gray"), tags: 1, selector: #selector(handlback))
    lazy var secondBackButton = createButtons(img: #imageLiteral(resourceName: "buttons-square-grayd"), tags: 1, selector: #selector(handlback))
    
    lazy var bottomStack:UIStackView = {
        let ss = MOLHLanguage.isRTLLanguage() ? getStack(views: nextButton,backButton, spacing: 16, distribution: .fillEqually, axis: .horizontal) : getStack(views: backButton,nextButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let bottomStack = MOLHLanguage.isRTLLanguage() ? getStack(views: ss,UIView(),skipButton, spacing: 16, distribution: .fill, axis: .horizontal) : getStack(views: skipButton,UIView(),ss, spacing: 16, distribution: .fill, axis: .horizontal)
        
        return bottomStack
    }()
    lazy var secondStack:UIStackView =  getStack(views: secondBackButton,paymentButton, spacing: 16, distribution: .fill, axis: .horizontal)
    
    lazy var skipButton = UIButton(title: "Skip".localized, titleColor: .lightGray, font: .systemFont(ofSize: 16), backgroundColor: .white, target: self, action: #selector(handleSkip))
    
    fileprivate let cellID="cellID"
    fileprivate let pagesImages = [#imageLiteral(resourceName: "2663530"),#imageLiteral(resourceName: "2427280"),#imageLiteral(resourceName: "2663530"),#imageLiteral(resourceName: "2427280")]
    var pages :[String] = [String]()
    var handlePaymentAction:(()->Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupCollectionView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          let animation = currentTableAnimation.getAnimation()
          let animator = CollectionViewAnimator(animation: animation)
          animator.animate(cell: cell, at: indexPath, in: collectionView)
      }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! BeforePaymentCell
        let page = pages[indexPath.item]
        cell.splashImageView.image = pagesImages[indexPath.item]
        cell.page = page
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let pa = pages[indexPath.item]
        
        let height = "".getFrameForText(text: pa)
        
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        backButton.image = pageControl.currentPage == 0 ? #imageLiteral(resourceName: "buttons-square-gray") : #imageLiteral(resourceName: "buttons-square-grayd")
        pageControl.currentPage == 3 ? hideOrUnhide(b: true, b2: false) : hideOrUnhide(b: false, b2: true)
        
    }
    
    //MARK: -user methods
    
    
    fileprivate func setupViews()  {
        
        secondStack.isHide(true)
        view.addSubViews(views: pageControl,bottomStack,secondStack)
        pageControl.anchor(top: nil, leading: nil, bottom: bottomStack.topAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 60, right: 0))
        pageControl.centerXInSuperview()
        bottomStack.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 32, bottom: 16, right: 32))
        secondStack.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 32, bottom: 16, right: 32))
    }
    
    fileprivate func setupCollectionView()  {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.backgroundColor = .white
        collectionView.register(BeforePaymentCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.isPagingEnabled = true
    }
    
    
    fileprivate func createButtons(img:UIImage,tags:Int,selector:Selector) -> UIImageView {
        let bt = UIImageView(image: img)
        bt.constrainWidth(constant: 60)
        bt.constrainHeight(constant: 60)
        bt.tag = tags
        bt.isUserInteractionEnabled = true
        bt.addGestureRecognizer(UITapGestureRecognizer(target: self, action: selector))
        return bt
    }
    
    fileprivate func hideOrUnhide(b:Bool,b2:Bool) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.secondStack.isHide(b2)
            self.bottomStack.isHide(b)
        })
        
    }
    
    //TODO: -handle methods

    
    @objc  func handleNext() {
        if pageControl.currentPage+1 < pages.count-1 {
            let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
            
            
            let indexPath = IndexPath(item: nextIndex, section: 0)
            pageControl.currentPage = nextIndex
            collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            backButton.image = pageControl.currentPage == 0 ? #imageLiteral(resourceName: "buttons-square-gray") : #imageLiteral(resourceName: "buttons-square-grayd")
            
            
            if nextIndex == pages.count - 1 {
                
                hideOrUnhide(b: false, b2: true)
            }
        }else {
            let indexPath = IndexPath(item: 3, section: 0)
            
            pageControl.currentPage = 3
            collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            hideOrUnhide(b: true, b2: false)
        }
        
        
    }
    
    @objc  func handlback() {
        
        if  pageControl.currentPage > 0  {
            let nextIndex = max(pageControl.currentPage - 1, 0)
            
            
            let indexPath = IndexPath(item: nextIndex, section: 0)
            pageControl.currentPage = nextIndex
            collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            backButton.image = pageControl.currentPage == 0 ? #imageLiteral(resourceName: "buttons-square-gray") : #imageLiteral(resourceName: "buttons-square-grayd")
            pageControl.currentPage == 3 ? hideOrUnhide(b: true, b2: false) : hideOrUnhide(b: false, b2: true)
        }
    }
    
    @objc func handlePayment()  {
        handlePaymentAction?()
        
    }
    
    @objc func handleSkip()  {
        handlePaymentAction?()
    }
}
