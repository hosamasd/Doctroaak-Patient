//
//  PharamacyResultsCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/1/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class PharamacyResultsCollectionVC: BaseCollectionVC {
     fileprivate let cellId = "cellId"
        var pharamacyArrayResults = [PharamacySearchModel]()
        var handlePharamacyCheckedIndex:((PharamacySearchModel)->Void)?

        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return pharamacyArrayResults.count
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PharamacyResultsCell
                cell.pharamacy = pharamacyArrayResults[indexPath.item]
          
            return cell
        }
        
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let lab = pharamacyArrayResults[indexPath.item]
                handlePharamacyCheckedIndex?(lab)
                
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let height:CGFloat = 120
            
            return .init(width: view.frame.width, height: height)
        }
        
        //MARK:-User methods
        
        
        override func setupCollection() {
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.contentInset.top = 16
            collectionView.backgroundColor = .white
            collectionView.register(PharamacyResultsCell.self, forCellWithReuseIdentifier: cellId)
        }
    }


