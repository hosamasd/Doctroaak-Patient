//
//  LABProfileOrderCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/2/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LABProfileOrderCollectionVC: BaseCollectionVC {
    
    fileprivate let cellId = "cellId"
       var pharamacyArray = [LABOrderPatientModel]()
       
         var handleCheckedIndex:((LABOrderPatientModel)->Void)?
         
         
         override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 60//pharamacyArray.count
         }
         
         override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LABProfileOrderCell
//             let pharamacy = pharamacyArray[indexPath.item]
//
//           cell.pharamacy=pharamacy
            cell.backgroundColor = .orange

             return cell
         }
         
         override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let pharamacy = pharamacyArray[indexPath.item]
           
             handleCheckedIndex?(pharamacy)
         }
         
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             
             return .init(width: view.frame.width, height: 250)
         }
         
         override func setupCollection() {
             collectionView.showsVerticalScrollIndicator = false
             collectionView.contentInset.top = 16
             collectionView.backgroundColor = .green
             collectionView.register(LABProfileOrderCell.self, forCellWithReuseIdentifier: cellId)
         }
}
