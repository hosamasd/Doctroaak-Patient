//
//  MainOrdersCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/3/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class MainOrdersCollectionVC: BaseCollectionVC {
    
    fileprivate let cellId = "cellId"
    fileprivate let cell2Id = "cell2Id"
    fileprivate let cell3Id = "cell3Id"
    fileprivate let cell4Id = "cell4Id"
    
    var doctorArray = [DoctorsOrderPatientModel]()
    var pharamacyArray = [PharamacyOrderPatientModel]()
    var labArray = [LABOrderPatientModel]()
    var radArray = [RadiologyOrderPatientModel]()
    
    var handleDCheckedIndex:((DoctorsOrderPatientModel)->Void)?
    var handlePYCheckedIndex:((PharamacyOrderPatientModel)->Void)?
    var handleLABCheckedIndex:((LABOrderPatientModel)->Void)?
    var handleRADCheckedIndex:((RadiologyOrderPatientModel)->Void)?
    var handleCheckedIndexForButtons:((Int)->Void)?

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60//pharamacyArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell
        if indexPath.item == 0 {
            cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainDoctorOrderCell
            
        }else if indexPath.item == 1 {
            cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cell2Id, for: indexPath) as! MainPharamacyOrderCell
            
        }else if indexPath.item == 2 {
            cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cell3Id, for: indexPath) as! MainLABOrderCell
            
        } else{
            cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cell4Id, for: indexPath) as! MainRadOrderCell
            
        }
        
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileOrderCell
        //        let doctor = pharamacyArray[indexPath.item]
        //
        //        cell.doctor=doctor
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x / 4
        //           menuBar.leftHorizentalBarViewConstraint.constant = x
        
    }
    
    func scrollToSpecificIndex(indexNumber:Int)  {
        let index = IndexPath(item: indexNumber, section: 0)
        
        collectionView.scrollToItem(at: index, at: .right, animated: true)
        if let titleLabel = navigationItem.titleView as? UILabel {
            //            titleLabel.text = "     \(titlesName[indexNumber])"
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let item = targetContentOffset.pointee.x / view.frame.width
        handleCheckedIndexForButtons?(Int(item))
//        let index = IndexPath(item: Int(item), section: 0)
        //        menuBar.collectionView.selectItem(at: index, animated: true, scrollPosition: .right)
        //
        //        if let titleLabel = navigationItem.titleView as? UILabel {
        //            titleLabel.text = titlesName[Int(item)]
        //        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let doctor = pharamacyArray[indexPath.item]
        
        //            handleCheckedIndex?(doctor)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
    override func setupCollection() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        collectionView.isPagingEnabled = true
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset.top = 16
        collectionView.backgroundColor = .white
        collectionView.register(MainDoctorOrderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(MainPharamacyOrderCell.self, forCellWithReuseIdentifier: cell2Id)
        collectionView.register(MainLABOrderCell.self, forCellWithReuseIdentifier: cell3Id)
        collectionView.register(MainRadOrderCell.self, forCellWithReuseIdentifier: cell4Id)
        
    }
    
}
