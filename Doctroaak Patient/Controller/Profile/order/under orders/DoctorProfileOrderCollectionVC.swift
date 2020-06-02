//
//  ProfileCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class DoctorProfileOrderCollectionVC: BaseCollectionVC {
    
    fileprivate let cellId = "cellId"
    var pharamacyArray = [DoctorsOrderPatientModel]()
    
      var handleCheckedIndex:((DoctorsOrderPatientModel)->Void)?
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pharamacyArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileOrderCell
        let doctor = pharamacyArray[indexPath.item]

        cell.doctor=doctor
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let doctor = pharamacyArray[indexPath.item]
        
        handleCheckedIndex?(doctor)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 250)
    }
    
    override func setupCollection() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset.top = 16
        collectionView.backgroundColor = .white
        collectionView.register(ProfileOrderCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
}
