//
//  ProfileCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class DoctorProfileOrderCollectionVC: BaseCollectionVC {
    
    var currentTableAnimation: CollectionAnimation = .fadeIn(duration: 0.25, delay: 0)

    fileprivate let cellId = "cellId"
    var pharamacyArray = [DoctorsOrderPatientModel]()
    
//    var handleCheckedIndex:((DoctorsOrderPatientModel)->Void)?
    var handleCheckedIndex:((DoctorsOrderPatientModel,IndexPath)->Void)?

    var handleCheckedIOpenImage:((UIImage)->Void)?
    var handleRateIndex:((DoctorsOrderPatientModel)->Void)?

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.noDataFound(pharamacyArray.count, text: "No Data Added Yet".localized)

        return pharamacyArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileOrderCell
                let doctor = pharamacyArray[indexPath.item]
        
                cell.doctor=doctor
        cell.handleCheckedIndex = {[unowned self] doctor in
            self.handleCheckedIndex?(doctor,indexPath)
        }
        cell.handleRateIndex = {[unowned self] doctor in
            self.handleRateIndex?(doctor)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 300)
    }
    
    override func setupCollection() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset.top = 16
        collectionView.backgroundColor = .white
        collectionView.register(ProfileOrderCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
}
