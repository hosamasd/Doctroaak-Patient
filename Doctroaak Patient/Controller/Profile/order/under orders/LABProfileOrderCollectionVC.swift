//
//  LABProfileOrderCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/2/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LABProfileOrderCollectionVC: BaseCollectionVC {
    
    fileprivate let cellId = "cellId"
    var pharamacyArray = [LABOrderPatientModel]()
    
    var handleCheckedIndex:((LABOrderPatientModel,IndexPath)->Void)?
    var handleCheckedIOpenImage:((UIImage)->Void)?
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.noDataFound(pharamacyArray.count, text: "No Data Added Yet".localized)
        
        return pharamacyArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LABProfileOrderCell
        let pharamacy = pharamacyArray[indexPath.item]
        
        cell.pharamacy=pharamacy
        cell.handleCheckedIOpenImage = {[unowned self] index in
            self.handleCheckedIOpenImage?(index)
        }
        cell.handleCheckedIndex = {[unowned self] doctor in
            self.handleCheckedIndex?(doctor,indexPath)
        }
        
        cell.addLapCollectionVC.medicineArray = getPharamacy()
        DispatchQueue.main.async {
            cell.addLapCollectionVC.collectionView.reloadData()
            
        }
        //        cell.addLapCollectionVC.medicineArray = getPharamacy()
        //        let isHide = cell.addLapCollectionVC.medicineArray.count > 0 ? false : true
        //        
        //        cell.addLapCollectionVC.collectionView.isHide(isHide)
        //        cell.addLapCollectionVC.collectionView.reloadData()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pharamacy = pharamacyArray[indexPath.item]
        
        //        handleCheckedIndex?(pharamacy)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 350)
    }
    
    override func setupCollection() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset.top = 16
        collectionView.backgroundColor = .white
        collectionView.register(LABProfileOrderCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func getPharamacy() -> [RadiologyOrderModel] {
        var medicine = [RadiologyOrderModel]()
        
        pharamacyArray.forEach { (ph) in
            ph.details?.forEach({ (p) in
                let dd = RadiologyOrderModel(raysID: p.analysisID)
                medicine.append(dd)
            })
        }
        return medicine
    }
}
