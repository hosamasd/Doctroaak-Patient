//
//  MainOrdersCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/3/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH

class MainOrdersCollectionVC: BaseCollectionVC {
    
    var currentTableAnimation: CollectionAnimation = .fadeIn(duration: 0.85, delay: 0.03)

    fileprivate let cellId = "cellId"
    fileprivate let cell2Id = "cell2Id"
    fileprivate let cell3Id = "cell3Id"
    fileprivate let cell4Id = "cell4Id"
    
    var doctorArray = [DoctorsOrderPatientModel]()
    var pharamacyArray = [PharamacyOrderPatientModel]()
    var labArray = [LABOrderPatientModel]()
    var radArray = [RadiologyOrderPatientModel]()
    
    var handleDCheckedIndex:((DoctorsOrderPatientModel,IndexPath)->Void)?
    var handlePYCheckedIndex:((PharamacyOrderPatientModel,IndexPath)->Void)?
    var handleLABCheckedIndex:((LABOrderPatientModel,IndexPath)->Void)?
    var handleRADCheckedIndex:((RadiologyOrderPatientModel,IndexPath)->Void)?
    //    var handleDCheckedIndex:((DoctorsOrderPatientModel)->Void)?
    //    var handlePYCheckedIndex:((PharamacyOrderPatientModel)->Void)?
    //    var handleLABCheckedIndex:((LABOrderPatientModel)->Void)?
    //    var handleRADCheckedIndex:((RadiologyOrderPatientModel)->Void)?
    var handleCheckedIndexForButtons:((Int)->Void)?
    var handleCheckedIOpenImage:((UIImage)->Void)?
    var handleRateIndex:((DoctorsOrderPatientModel)->Void)?
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        var cell:UICollectionViewCell
        if indexPath.item == 0 {
            let  cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainDoctorOrderCell
            cell.doctorProfileOrderCollectionVC.pharamacyArray=doctorArray
            cell.doctorProfileOrderCollectionVC.collectionView.reloadData()
            cell.handleDoctorCheckedIndex = {[unowned self] doc,index in
                self.handleDCheckedIndex?(doc,index)
            }
            cell.handleRateIndex = {[unowned self] doctor in
                self.handleRateIndex?(doctor)
            }
            
            return cell
            
        }else if indexPath.item == 1 {
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cell2Id, for: indexPath) as! MainPharamacyOrderCell
            cell.pharamacyProfileOrderCollectionVC.pharamacyArray=pharamacyArray
            //            cell.pharamacyProfileOrderCollectionVC
            cell.pharamacyProfileOrderCollectionVC.collectionView.reloadData()
            cell.handleCheckedIOpenImage = {[unowned self] index in
                self.handleCheckedIOpenImage?(index)
            }
            cell.handlePharmacyCheckedIndex = {[unowned self] doc,index in
                self.handlePYCheckedIndex?(doc,index)
            }
            return cell
            
        }else if indexPath.item == 2 {
            let  cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cell3Id, for: indexPath) as! MainLABOrderCell
            cell.labProfileOrderCollectionVC.pharamacyArray=labArray
            cell.labProfileOrderCollectionVC.collectionView.reloadData()
            cell.handleCheckedIOpenImage = {[unowned self] index in
                self.handleCheckedIOpenImage?(index)
            }
            cell.handleLABCheckedIndex = {[unowned self] doc,index in
                self.handleLABCheckedIndex?(doc,index)
            }
            return cell
            
        } else{
            let  cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cell4Id, for: indexPath) as! MainRadOrderCell
            cell.radiologyProfileOrderCollectionVC.pharamacyArray=radArray
            cell.radiologyProfileOrderCollectionVC.collectionView.reloadData()
            cell.handleCheckedIOpenImage = {[unowned self] index in
                self.handleCheckedIOpenImage?(index)
            }
            cell.handleRadCheckedIndex = {[unowned self] doc,index in
                self.handleRADCheckedIndex?(doc,index)
            }
            return cell
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x / 4
        //           menuBar.leftHorizentalBarViewConstraint.constant = x
        
    }
    
    func scrollToSpecificIndex(indexNumber:Int)  {
        let index = IndexPath(item: indexNumber, section: 0)
        
        let direction:UICollectionView.ScrollPosition = MOLHLanguage.isRTLLanguage() ? .left : .right
        
        //        collectionView.scrollToItem(at: index, at: direction, animated: true)
        
        collectionView.scrollToItem(at: index, at: .right, animated: true)
    }
    
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        var xcd:CGFloat = 0.0
        if MOLHLanguage.isRTLLanguage() {
            
            if targetContentOffset.pointee.x ==  1077.0 {
                xcd = 0.0
            }else if targetContentOffset.pointee.x == 718.0{
                xcd = 359.0
            }else if targetContentOffset.pointee.x == 359.0 {
                xcd = 718.0
            }else {
                xcd=1077.0
            }
            
            let dd = xcd / view.frame.width
            handleCheckedIndexForButtons?(Int(dd));return
            
        }else {
            let item = targetContentOffset.pointee.x / view.frame.width
            handleCheckedIndexForButtons?(Int(item));return
            
        }
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
