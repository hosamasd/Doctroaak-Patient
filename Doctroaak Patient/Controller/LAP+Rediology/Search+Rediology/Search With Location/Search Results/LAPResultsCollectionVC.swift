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
    var handleLabCheckedIndex:((LapSearchModel)->Void)?
    var handleRdiologyCheckedIndex:((RadiologySearchModel)->Void)?

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return index == 0 ? labArrayResults.count : radiologyArrayResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LAPResultsCell
        if index == 0 {
            cell.lab = labArrayResults[indexPath.item]
        }else {
            cell.rad = radiologyArrayResults[indexPath.item]
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if index == 0 {
            let lab = labArrayResults[indexPath.item]
            handleLabCheckedIndex?(lab)
            
        }else{
            let rad = radiologyArrayResults[indexPath.item]
            handleRdiologyCheckedIndex?(rad)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height:CGFloat = index == 10 ? 150 : 120
        
        return .init(width: view.frame.width, height: height)
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
