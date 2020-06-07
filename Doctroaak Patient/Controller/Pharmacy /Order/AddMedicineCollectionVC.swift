//
//  AddMedicineCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class AddMedicineCollectionVC: BaseCollectionVC {
    
    fileprivate let cellID = "cellID"
    var medicineArray = [PharamcyOrderModel]()
    var showOrderOnly:Bool = false
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        collectionView.noDataFound(medicineArray.count, text: "No Data Added Yet".localized)

        return medicineArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AddMedicineCell
        let med = medicineArray[indexPath.item]
//
        cell.med = med
//        cell.handleRemovePharamcay={[unowned self] (m) in
//            self.handleRemovePharamcay?(m,indexPath.item)
//        }
        [cell.typeLabel,cell.closeImage].forEach({$0.isHide(showOrderOnly ? true : false)})
        cell.handleRemovePharamcay = {[unowned self] item in
            self.medicineArray.removeAll(where: {$0.medicineID==item.medicineID})
            self.collectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 60)
    }
    
    //MARK:-User methods

    
    override func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.register(AddMedicineCell.self, forCellWithReuseIdentifier: cellID)
    }
    
  
}
