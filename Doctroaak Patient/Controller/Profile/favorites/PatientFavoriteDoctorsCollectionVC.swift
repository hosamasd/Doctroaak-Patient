//
//  CardiologyCollectionVC.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class PatientFavoriteDoctorsCollectionVC: BaseCollectionVC  {
    var currentTableAnimation: CollectionAnimation = .fadeIn(duration: 0.85, delay: 0.03)

    fileprivate let cellId = "cellId"
    var handleCheckedIndex:((PatientSearchDoctorsModel)->Void)?
    var doctorsArray:[PatientSearchDoctorsModel] = [PatientSearchDoctorsModel]()
    
//    var handleBookmarkDoctor:((PatientSearchDoctorsModel)->Void)?
    var handleBookmarkDoctor:((PatientSearchDoctorsModel)->Void)?
    var handleCheckedDoctor:((PatientSearchDoctorsModel)->Void)?

    var isFavorite:Bool = false
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.noDataFound(doctorsArray.count, text: "No Favorite Doctor Added Yet".localized)
           return doctorsArray.count
       }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PatientFavoriteDoctorsCell
        let doctor = doctorsArray[indexPath.item]
        cell.doctor=doctor
        cell.handleBookmarkDoctor = {[unowned self] doctors in
            self.handleBookmarkDoctor?(doctors)
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
        collectionView.register(PatientFavoriteDoctorsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
}
