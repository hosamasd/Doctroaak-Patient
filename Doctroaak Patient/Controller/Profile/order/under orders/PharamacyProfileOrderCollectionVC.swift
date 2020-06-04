//
//  PharamacyProfileOrderCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/2/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class PharamacyProfileOrderCollectionVC: BaseCollectionVC {
    
    fileprivate let cellId = "cellId"
    var pharamacyArray = [PharamacyOrderPatientModel]()
    
    var handleCheckedIndex:((PharamacyOrderPatientModel,IndexPath)->Void)?
    
    //    var handleCheckedIndex:((PharamacyOrderPatientModel)->Void)?
    var handleCheckedIOpenImage:((UIImage)->Void)?
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pharamacyArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PharamacyProfileOrderCell
        
        let pharamacy = pharamacyArray[indexPath.item]
        
        cell.pharamacy=pharamacy
        cell.handleCheckedIOpenImage = {[unowned self] index in
            self.handleCheckedIOpenImage?(index)
        }
        cell.handleCheckedIndex = {[unowned self] doctor in
            self.handleCheckedIndex?(doctor,indexPath)
        }
        cell.addMedicineCollectionVC.medicineArray = getPharamacy()
        cell.addMedicineCollectionVC.collectionView.reloadData()
        
        return cell
    }
    
    func getPharamacy() -> [PharamcyOrderModel] {
        var medicine = [PharamcyOrderModel]()
        
        pharamacyArray.forEach { (ph) in
            ph.details?.forEach({ (p) in
                let d = PharamcyOrderModel(medicineID: p.medicineID, medicineTypeID: p.medicineTypeID, amount: p.amount)
                medicine.append(d)
            })
        }
        return medicine
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pharamacy = pharamacyArray[indexPath.item]
        
        //        handleCheckedIndex?(pharamacy)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 250)
    }
    
    override func setupCollection() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset.top = 16
        collectionView.backgroundColor = .white
        collectionView.register(PharamacyProfileOrderCell.self, forCellWithReuseIdentifier: cellId)
    }
}
