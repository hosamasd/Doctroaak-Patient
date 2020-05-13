//
//  DoctorWorkingDateCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class DoctorWorkingDateCollectionVC: BaseCollectionVC {
    
    fileprivate let cellId = "cellId"
    var workingDaysArray = [WorkingHourModel]()
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var ss = 0
        
        workingDaysArray.forEach { (w) in
            let d = w.active == 0 ? 0 : 1
            ss += d
        }
        return  ss//workingDaysArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DoctorWorkingDateCell
        let index = indexPath.item
        let day = workingDaysArray[indexPath.item]
        
        cell.day=day
        [ cell.doctorSecondTimeLabel,cell.doctorDaySecondLastTimeLabel].forEach({$0.isHide(index%2 == 0 ? true : false)})
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let index = workingDaysArray[indexPath.item]
        
        let height:CGFloat = index.active == 0 ? 0 : 60
        
        return .init(width: view.frame.width, height: 60)
    }
    
    override func setupCollection() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(DoctorWorkingDateCell.self, forCellWithReuseIdentifier: cellId)
    }
}
