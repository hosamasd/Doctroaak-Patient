//
//  LAPResultsCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LAPResultsCollectionVC: BaseCollectionVC {
    
    fileprivate let cellId = "cellId"
    var labArrayResults = [LapSearchModel]()
    var radiologyArrayResults = [RadiologySearchModel]()
    var index:Int = 0 //0 for lab 1 for residology
    var handleCheckedIndex:((IndexPath)->Void)?
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return index == 0 ? labArrayResults.count : radiologyArrayResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LAPResultsCell
//        let lab =  labArrayResults[indexPath.item]
//        let rad = radiologyArrayResults[indexPath.item]
        if index == 0 {
            cell.lab = labArrayResults[indexPath.item]
        }else {
            cell.rad = radiologyArrayResults[indexPath.item]
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleCheckedIndex?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 120)
    }
    
    //MARK:-User methods
    
    
    override func setupCollection() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset.top = 16
        collectionView.backgroundColor = .white
        collectionView.register(LAPResultsCell.self, forCellWithReuseIdentifier: cellId)
    }
}
