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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icuArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ICUResultsCell
        let icu = icuArray[indexPath.item]
        
        cell.icu=icu
        cell.profileImage.backgroundColor = indexPath.item % 2 == 0 ? .gray : .yellow

        return cell
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
