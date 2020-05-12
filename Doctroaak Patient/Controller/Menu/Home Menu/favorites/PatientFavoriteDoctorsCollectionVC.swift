//
//  CardiologyCollectionVC.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class PatientFavoriteDoctorsCollectionVC: BaseCollectionVC  {
    
    fileprivate let cellId = "cellId"
    var handleCheckedIndex:((PatientSearchDoctorsModel)->Void)?
    var doctorsArray:[PatientSearchDoctorsModel] = [PatientSearchDoctorsModel]()
    var handleBookmarkDoctor:((PatientSearchDoctorsModel)->Void)?

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doctorsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PatientFavoriteDoctorsCell
        let doctor = doctorsArray[indexPath.item]
        cell.doctor=doctor
        cell.handleBookmarkDoctor = {[unowned self] doctor in
            self.handleBookmarkDoctor?(doctor)
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
