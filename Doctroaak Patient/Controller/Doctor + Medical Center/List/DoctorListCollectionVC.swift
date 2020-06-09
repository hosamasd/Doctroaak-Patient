//
//  DoctorListCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class DoctorListCollectionVC: BaseCollectionVC {
    
    var specificationArray = [SpecificationModel]()
    fileprivate let cellId = "cellId"
    var index = 0
    
    var handleCheckedIndex:((Int)->Void)?
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.noDataFound(specificationArray.count, text: "No Data Added Yet".localized)

        return specificationArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DoctorHomeListCell
        let spy = specificationArray[indexPath.item]
        cell.index = index
        cell.spy = spy
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let spy = specificationArray[indexPath.item]

        handleCheckedIndex?(spy.id)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2 * 8 ) / 3
        
        return .init(width: width, height: 150)
    }
    
    //TODO: -handle methods
    
    override func setupCollection() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(DoctorHomeListCell.self, forCellWithReuseIdentifier: cellId)
    }

}
