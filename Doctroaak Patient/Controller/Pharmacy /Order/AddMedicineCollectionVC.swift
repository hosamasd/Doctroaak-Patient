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
    var medicineArray = [MedicineAddModel]()
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medicineArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AddMedicineCell
        let med = medicineArray[indexPath.item]
//        
        cell.med = med
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
