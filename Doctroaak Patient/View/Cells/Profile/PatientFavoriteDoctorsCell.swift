//
//  CardinolgyCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import SDWebImage
import MOLH

class PatientFavoriteDoctorsCell: BaseCollectionCell {
    
    var doctor:PatientSearchDoctorsModel? {
        didSet{
            guard let doctor = doctor else { return  }
            let x = MOLHLanguage.isRTLLanguage() ? doctor.doctor.nameAr ?? doctor.doctor.name ?? "" : doctor.doctor.name ?? ""
            let d = MOLHLanguage.isRTLLanguage() ?  doctor.degree?.nameAr ?? doctor.degree?.name ??  "" :  doctor.degree?.name ?? ""
            
            putAttributedText(la: profileInfoLabel, ft: x+"\n", st: d+"\n")
            profileInfoAddressLabel.text = "\(getCityFromIndex(doctor.city.toInt() ?? 1)) , \(getAreaFromIndex(doctor.area.toInt() ?? 1 )) " //"\(doctor.city) , \(doctor.area)"
            profileInfoReservationLabel.text = "Reservation".localized + " : \(doctor.fees)" + " EGY".localized
            profileInfoConsultaionLabel.text = "Consultation".localized + " : \(doctor.fees2)" + " EGY".localized
            for(index,view) in starsStackView.arrangedSubviews.enumerated(){
                guard let img = view as? UIImageView else {return}
                
                let ratingInt = Int(doctor.reservationRate ?? "0" )
                img.image = index >= ratingInt ?? 0 ? #imageLiteral(resourceName: "star-1") : #imageLiteral(resourceName: "star")
                let ss = doctor.doctor.photo
                guard let url = URL(string: ss) else { return  }
                profileImage.sd_setImage(with: url)
                bookmarkImage.image = isFavorite ? #imageLiteral(resourceName: "ic_favorite_24px") : #imageLiteral(resourceName: "ic_favorite_border_24px")
                
            }
        }
    }
    
    var secondDoctor:PatientFavoriteModel? {
        didSet{
            guard let doctor = secondDoctor else { return  }
            let x = MOLHLanguage.isRTLLanguage() ? doctor.doctor.nameAr ?? doctor.doctor.name : doctor.doctor.name
            let d = MOLHLanguage.isRTLLanguage() ?  doctor.doctor.degree?.nameAr ?? doctor.doctor.degree?.name ?? "" :  doctor.doctor.degree?.name ?? ""
            
            putAttributedText(la: profileInfoLabel, ft: x+"\n", st: d+"\n\n")
            profileInfoAddressLabel.text = "\(getCityFromIndex(doctor.city.toInt() ?? 1)) , \(getAreaFromIndex(doctor.area.toInt() ?? 1 )) " //"\(doctor.city) , \(doctor.area)"
            profileInfoReservationLabel.text = "Reservation: \(doctor.fees) EGY"
            profileInfoConsultaionLabel.text = "Consultation: \(doctor.fees2) EGY"
            for(index,view) in starsStackView.arrangedSubviews.enumerated(){
                guard let img = view as? UIImageView else {return}
                
                let ratingInt = Int(doctor.doctor.reservationRate ?? "0" )
                img.image = index >= ratingInt ?? 0 ? #imageLiteral(resourceName: "star-1") : #imageLiteral(resourceName: "star")
                let ss = doctor.doctor.photo//.removeSubstringAfterOrBefore(needle: "http", beforeNeedle: false) else { return  }
                //            let dd = "http"+ss ?? ""
                guard let url = URL(string: ss) else { return  }
                profileImage.sd_setImage(with: url)
                bookmarkImage.image = isFavorite ? #imageLiteral(resourceName: "ic_favorite_24px") : #imageLiteral(resourceName: "ic_favorite_border_24px")
                
                
            }
        }
    }
    
    
    lazy var profileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 60)
        i.constrainHeight(constant: 60)
        i.layer.cornerRadius = 30
        i.clipsToBounds = true
        return i
    }()
    lazy var profileInfoLabel:UILabel = {
        let l = UILabel()
        
        l.numberOfLines = 2
        return l
    }()
    lazy var profileInfoAddressLabel = UILabel(text: "Fifth Settlement, New Cairo", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoReservationLabel = UILabel(text: "Reservation : 200.0 EGP", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoConsultaionLabel = UILabel(text: "Consultation : 50.0 EGP", font: .systemFont(ofSize: 16), textColor: .black)
    
    lazy var profileInfoAddressButton = createImagess(image: #imageLiteral(resourceName: "ic_room_24px"))
    lazy var profileInfoReservationButton = createImagess(image: #imageLiteral(resourceName: "ic_date_range_24px"))
    lazy var profileInfoConsultaionButton = createImagess(image: #imageLiteral(resourceName: "avatar"))
    
    lazy var firstStack:UIStackView = {
        let b =  hstack(profileInfoAddressButton,profileInfoAddressLabel,spacing:8)
        return b
    }()
    lazy var secondStack:UIStackView = {
        let b = hstack(profileInfoReservationButton,profileInfoReservationLabel,spacing:8)
        return b
    }()
    lazy var thirdStack:UIStackView = {
        let b = hstack(profileInfoConsultaionButton,profileInfoConsultaionLabel,spacing:8)
        return b
    }()
    //
    lazy var totalStackFinished:UIStackView = {
        let b = stack(firstStack,secondStack,thirdStack,spacing:8)
        return b
    }()
    
    lazy var seperatorView:UIView = {
        let v = UIView(backgroundColor: .lightGray)
        v.constrainHeight(constant: 1)
        return v
    }()
    lazy var starsStackView:UIStackView = {
        var arrangedViews = [ UIView]()
        (0..<5).forEach({ (_) in
            let im = UIImageView(image:#imageLiteral(resourceName: "star"))
            im.constrainWidth(constant: 24)
            im.constrainHeight(constant: 24)
            arrangedViews.append(im)
        })
        arrangedViews.append(UIView())
        let stack = UIStackView(arrangedSubviews: arrangedViews)
        return stack
    }()
    lazy var bookmarkImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_favorite_border_24px"))
        i.constrainWidth(constant: 30)
        i.isUserInteractionEnabled = true
        i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBookmark)))
        
        return i
    }()
    var handleBookmarkDoctor:((PatientSearchDoctorsModel)->Void)?
    var handleCheckedDoctor:((PatientSearchDoctorsModel)->Void)?
    var isFavorite = false {
        didSet {
            bookmarkImage.image = isFavorite ? #imageLiteral(resourceName: "ic_favorite_24px") : #imageLiteral(resourceName: "ic_favorite_border_24px")
            
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = false
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 20)
        layer.shadowRadius = 20
        layer.opacity = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        setupViewss()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewss() {
        [profileInfoAddressLabel,profileInfoReservationLabel,profileInfoConsultaionLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
        
        //        setupShadow(opacity: 0.8, radius: 10, offset: .init(width: 0, height: 10), color: .red)
        //        addSubview(totalStackFinished)
        //        totalStackFinished.fillSuperview()
        let ss = stack(profileImage,UIView())
        let dd = stack(profileInfoLabel,totalStackFinished).withMargins(.init(top: -16, left: 0, bottom: 0, right: 0))
        
        let bottom = hstack(starsStackView,bookmarkImage)
        let total = hstack(ss,dd,spacing:16)
        stack(total,seperatorView,bottom,spacing:8).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
        
        
    }
    
    func createImagess(image:UIImage) -> UIImageView {
        let b = UIImageView(image: image)
        //        b.setImage(image, for: .normal)
        b.constrainWidth(constant: 20)
        b.constrainHeight(constant: 20)
        return b
    }
    
    
    
    @objc func handleBookmark()  {
        guard let docotr = doctor else { return  }
        isFavorite = !isFavorite
        bookmarkImage.image = isFavorite ? #imageLiteral(resourceName: "ic_favorite_24px") : #imageLiteral(resourceName: "ic_favorite_border_24px")
        handleBookmarkDoctor?(docotr)
    }
    
//    func putAttributedText(la:UILabel,ft:String,st:String)  {
//        let attributeText = NSMutableAttributedString(string: ft, attributes:  [.font : UIFont.boldSystemFont(ofSize: 18)])
//        attributeText.append(NSAttributedString(string: st, attributes: [.font : UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor.lightGray]))
//        la.attributedText = attributeText
//    }
}
