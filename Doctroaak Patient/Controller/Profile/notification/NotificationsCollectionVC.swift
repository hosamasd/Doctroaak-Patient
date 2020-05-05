//
//  NotificationsCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class NotificationsCollectionVC: BaseCollectionVC {
    
       fileprivate let cellId = "cellId"
       
       override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 10
       }
       
       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NotificationCell
           
           return cell
       }
       
      
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           //        let width = (view.frame.wid15th - 56 ) / 2
           let ss = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."
           
           
           let height = ss.getFrameForText(text: ss)
           return .init(width: view.frame.width, height: height.height)
       }
       
       //MARK:-User methods
       
       override func setupCollection() {
           collectionView.showsVerticalScrollIndicator = false
           collectionView.backgroundColor = #colorLiteral(red: 0.9561814666, green: 0.9626725316, blue: 0.9625836015, alpha: 1)
           collectionView.register(NotificationCell.self, forCellWithReuseIdentifier: cellId)
       }
}
