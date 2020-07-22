//
//  PatientFavoritessDoctorsCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/1/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH

class PatientFavoritessDoctorsCollectionVC: BaseCollectionVC {
    

 fileprivate let cellId = "cellId"
    var currentTableAnimation: CollectionAnimation = .fadeIn(duration: 0.25, delay: 0)

    var handleCheckedIndex:((PatientFavoriteModel)->Void)?
    var doctorsArray:[PatientFavoriteModel] = [PatientFavoriteModel]()
//    var doctorsSecondArray:[PatientSearchDoctorsModel] = [PatientSearchDoctorsModel]()

//    var handleBookmarkDoctor:((PatientSearchDoctorsModel)->Void)?
    var handleBookmarkDoctor:((PatientFavoriteModel,IndexPath)->Void)?

    var isFavorite:Bool = false
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
             let animation = currentTableAnimation.getAnimation()
             let animator = CollectionViewAnimator(animation: animation)
             animator.animate(cell: cell, at: indexPath, in: collectionView)
         }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.noDataFound(doctorsArray.count, text: "No Favorite Doctor Added Yet".localized)
           return doctorsArray.count
       }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PatientFavoritessDoctorsCell
        let doctor = doctorsArray[indexPath.item]
        cell.doctor=doctor
        cell.handleBookmarkDoctor = {[unowned self] doctors in
            self.handleBookmarkDoctor?(doctors,indexPath)
        }
        //        cell.doctor = doctor
        //        cell.isFavorite = true
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let doctor = doctorsArray[indexPath.item]
        handleCheckedIndex?(doctor)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 180)
    }
    
    override func setupCollection() {
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset.top = 16
        collectionView.backgroundColor = .white
        collectionView.register(PatientFavoritessDoctorsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
}
