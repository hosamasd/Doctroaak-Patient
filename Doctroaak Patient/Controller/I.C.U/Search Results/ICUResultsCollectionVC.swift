//
//  ICUResultsCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ICUResultsCollectionVC: BaseCollectionVC {
    
    fileprivate let cellId = "cellId"
    var icuArray =  [ICUFilterModel]()
    var icubationArray =  [IncubtionSearchModel]()
    var index:Int = 0
    var handleSelectedItem:((ICUFilterModel)->Void)?
    var handleSecondSelectedItem:((IncubtionSearchModel)->Void)?
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.noDataFound(icuArray.count, text: "No Data Added Yet".localized)
        
        return index == 0 ?  icuArray.count : icubationArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ICUResultsCell
        if index == 0 {
            cell.icu = icuArray[indexPath.item]
        }else {
            cell.incubation = icubationArray[indexPath.item]
        }
        
        cell.profileImage.backgroundColor = indexPath.item % 2 == 0 ? .gray : .yellow
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if index == 0 {
            let ic = icuArray[indexPath.item]
            handleSelectedItem?(ic)
            
        }else {
            let ic = icubationArray[indexPath.item] 
            handleSecondSelectedItem?(ic)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 120)
    }
    
    override func setupCollection() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset.top = 16
        collectionView.backgroundColor = .white
        collectionView.register(ICUResultsCell.self, forCellWithReuseIdentifier: cellId)
    }
}
