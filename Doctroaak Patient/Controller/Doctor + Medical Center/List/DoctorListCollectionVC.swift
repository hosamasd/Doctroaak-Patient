//
//  DoctorListCollectionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class DoctorListCollectionVC: BaseCollectionVC {
    
    var images:[UIImage] = [#imageLiteral(resourceName: "cardiovascular"),#imageLiteral(resourceName: "chest"),#imageLiteral(resourceName: "teeth"),#imageLiteral(resourceName: "teeth"),#imageLiteral(resourceName: "teeth"),#imageLiteral(resourceName: "teeth"),#imageLiteral(resourceName: "teeth")]
    var deatas = ["Cardiology","Chest","Dentist ","Dentist","Dentist","Dentist","Dentist"]
    fileprivate let cellId = "cellId"
    
    var handleCheckedIndex:((IndexPath)->Void)?
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deatas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DoctorHomeListCell
        cell.docImage.image = images[indexPath.item]
        cell.docLabel.text = deatas[indexPath.item]
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleCheckedIndex?(indexPath)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2 * 8 ) / 3
        
        return .init(width: width, height: 150)
    }
    
    //TODO: -handle methods
    
    override func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.register(DoctorHomeListCell.self, forCellWithReuseIdentifier: cellId)
    }

}
