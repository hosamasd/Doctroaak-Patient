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
    var index = 10 // for DeatilsSelectedDoctorsVC
    
    var workingDaysArray = [WorkingHourModel]()
    
    var labWorkingDaysArray = [LabWorkingHourModel]()
    var radWorkingDaysArray = [RadiologyWorkingHourModel]()
    
    
    fileprivate func getTotalDays(_ ss: inout Int) {
        labWorkingDaysArray.forEach { (w) in
            let d = w.active == 0 ? 0 : 1
            ss += d
        }
    }
    
    fileprivate func getLabTotalDays(_ ss: inout Int) {
        workingDaysArray.forEach { (w) in
            let d = w.active == 0 ? 0 : 1
            ss += d
        }
    }
    
    fileprivate func getRadTotalDays(_ ss: inout Int) {
        radWorkingDaysArray.forEach { (w) in
            let d = w.active == 0 ? 0 : 1
            ss += d
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var ss = 0
        index == 0 ? getLabTotalDays(&ss) : index == 1 ?  getRadTotalDays(&ss) :  getTotalDays(&ss)
        //        getTotalDays(&ss)
        return  ss//workingDaysArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DoctorWorkingDateCell
        if workingDaysArray.count > 0  {
            let index = workingDaysArray[indexPath.item]
            cell.day=index
        }else if labWorkingDaysArray.count > 0 {
            let index = labWorkingDaysArray[indexPath.item]
            cell.lab=index
        }else if radWorkingDaysArray.count > 0 {
            let index = radWorkingDaysArray[indexPath.item]
            cell.rad=index
        }
        //        let index = indexPath.item
        //        let day = workingDaysArray[indexPath.item]
        //
        //        cell.day=day
        [ cell.doctorSecondTimeLabel,cell.doctorDaySecondLastTimeLabel].forEach({$0.isHide(index == 10 ? true : false)})
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height:CGFloat
        
        if workingDaysArray.count > 0  {
            let index = workingDaysArray[indexPath.item]
            height = index.active == 0 ? 0 : 60
        }else if labWorkingDaysArray.count > 0 {
            let index = labWorkingDaysArray[indexPath.item]
            height = index.active == 0 ? 0 : 60
        }else if radWorkingDaysArray.count > 0 {
            let index = radWorkingDaysArray[indexPath.item]
            height = index.active == 0 ? 0 : 60
        }
        //        let index = workingDaysArray[indexPath.item]
        //        
        //        let height:CGFloat = index.active == 0 ? 0 : 60
        
        return .init(width: view.frame.width, height: 60)
    }
    
    override func setupCollection() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(DoctorWorkingDateCell.self, forCellWithReuseIdentifier: cellId)
    }
}
