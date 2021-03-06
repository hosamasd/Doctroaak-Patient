//
//  ProfileCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ProfileOrderCollectionVC: BaseCollectionVC {
    
    fileprivate let cellId = "cellId"
       var handleCheckedIndex:((IndexPath)->Void)?

       
       override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 10
       }
       
       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CardinolgyCell
           
           return cell
       }
       
       override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           handleCheckedIndex?(indexPath)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
           return .init(width: view.frame.width, height: 180)
       }
       
       override func setupCollection() {
           collectionView.showsVerticalScrollIndicator = false
           collectionView.showsHorizontalScrollIndicator = false
           collectionView.contentInset.top = 16
           collectionView.backgroundColor = .white
           collectionView.register(CardinolgyCell.self, forCellWithReuseIdentifier: cellId)
       }

    
}
