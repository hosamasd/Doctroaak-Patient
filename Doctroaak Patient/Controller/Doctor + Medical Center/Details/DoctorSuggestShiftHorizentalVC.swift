//
//  DoctorSuggestShiftHorizentalVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class DoctorSuggestShiftHorizentalVC: BaseCollectionVC {
    
    fileprivate let cellId = "cellId"
    var suggestedDaysArray = [FreeDayModel]()
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.noDataFound(suggestedDaysArray.count, text: "No Days Available Yet".localized)

        return suggestedDaysArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DoctorDaysShiftCell
        let day = suggestedDaysArray[indexPath.item]
        
        cell.day=day
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 56 ) / 2
        
        return .init(width: width, height: 150)
    }
    
    override func setupCollection() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.backgroundColor = .white
        collectionView.register(DoctorDaysShiftCell.self, forCellWithReuseIdentifier: cellId)
    }
}
