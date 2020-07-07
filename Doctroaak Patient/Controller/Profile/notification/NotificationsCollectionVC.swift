//
//  NotificationsCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
//import <#module#>

class NotificationsCollectionVC: BaseCollectionVC {
    
    var currentTableAnimation: CollectionAnimation = .fadeIn(duration: 0.85, delay: 0.03)

    fileprivate  let cellID = "cellID"
    var notificationArray = [PatientNotificationModel]()
    var handledisplayNotification:((PatientNotificationModel,IndexPath)->Void)?
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.noDataFound(notificationArray.count, text: "No Data Added Yet".localized)
        
        return notificationArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! NotificationCell
        let epoisde = notificationArray[indexPath.row]
        
        cell.notify = epoisde
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noty = notificationArray[indexPath.item]
        makePostAlert(post: noty,indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = notificationArray[indexPath.item]
        
        let height = message.messageEn.getFrameForText(text: message.messageEn)
        return .init(width: view.frame.width, height: height.height+100)
        
    }
    
    
    //MARK:-User methods
    
    func makePostAlert(post:PatientNotificationModel,_ index:IndexPath)  {
        let alert = UIAlertController(title: "Choose Options".localized, message: "What do you want to make?".localized, preferredStyle: .actionSheet)
//        let display = UIAlertAction(title: "Display".localized, style: .default) { (_) in
//            self.handledisplayNotification?(post,index)
//
//        }
        let delete = UIAlertAction(title: "Delete".localized, style: .destructive) { (_) in
            self.handledisplayNotification?(post,index)
            
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .default) { (_) in
            alert.dismiss(animated: true)
        }
//        alert.addAction(display)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    override func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.register(NotificationCell.self, forCellWithReuseIdentifier: cellID)
    }
}
