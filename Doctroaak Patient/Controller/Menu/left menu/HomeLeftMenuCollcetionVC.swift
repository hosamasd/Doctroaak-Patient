//
//  HomeLeftMenuCollcetionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class HomeLeftMenuCollcetionVC: BaseCollectionVC {
    
    var images:[UIImage] = [#imageLiteral(resourceName: "icon"),#imageLiteral(resourceName: "ic_language_24px"),#imageLiteral(resourceName: "star-2"),#imageLiteral(resourceName: "ic_phone_24px"),#imageLiteral(resourceName: "ic_language_24px")]
    var deatas = ["Profile","Anayltics","Notifications","Contact Us","Language"]
    
    
    
    fileprivate let cellId = "cellId"
    
    var handleCheckedIndex:((IndexPath)->Void)?
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deatas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainLeftMenuCell
        cell.Image6.image = images[indexPath.item]
        cell.Label6.text = deatas[indexPath.item]
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleCheckedIndex?(indexPath)
//        checkIfLoggined(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 60)
    }
    
    override func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.register(MainLeftMenuCell.self, forCellWithReuseIdentifier: cellId)
    }
}
