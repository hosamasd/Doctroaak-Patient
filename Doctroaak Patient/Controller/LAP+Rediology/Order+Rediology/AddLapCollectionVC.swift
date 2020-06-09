//
//  AddLapCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit


class AddLapCollectionVC: BaseCollectionVC {
    
    fileprivate let cellID = "cellID"
    var medicineArray = [RadiologyOrderModel]()//["one","two","three","four","fifie"]
    var index:Int = 0
    var showOrderOnly:Bool = false
//    var medicineTextsArray = [String]()
    var handleRemoveItem:((RadiologyOrderModel,IndexPath)->Void)?
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.noDataFound(medicineArray.count, text: "No Data Added Yet".localized)
        
        return medicineArray.count//medicineArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AddLAPCell
        let meds = medicineArray[indexPath.item]
        
        //
        cell.index=index
        cell.med=meds
        [cell.closeImage].forEach({$0.isHide(showOrderOnly ? true : false)})
        
        cell.handleRemoveItem = {[unowned self] item in
            self.handleRemoveItem?(item,indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 60)
    }
    
    //MARK:-User methods
    
    
    
    override func setupCollection() {
        collectionView.backgroundColor = .white
        //        collectionView.backgroundColor = .red
        collectionView.register(AddLAPCell.self, forCellWithReuseIdentifier: cellID)
    }
}
