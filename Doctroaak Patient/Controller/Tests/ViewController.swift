//
//  ViewController.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: CustomBaseViewVC {

    lazy var cusomBookView:CustomTestView = {
        let v = CustomTestView()
//        v.boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
//        v.girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
//        v.shift1Button.addTarget(self, action: #selector(handle1Shift), for: .touchUpInside)
//        v.shift2Button.addTarget(self, action: #selector(handle2Shift), for: .touchUpInside)
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Asd", style: .plain, target: self, action: #selector(handles))
//        navigationController?.navigationBar.isHide(true)
    }

    override func setupViews() {
        
//        view.addSubViews(views: cusomBookView)
//        cusomBookView.fillSuperview()
    }
    
    //open file picker
    @objc func handles()  {

        
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)

//        let importMenu = UIDocumentPickerViewController(documentTypes:  ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String], in: .import)
//
//        importMenu.delegate = self
//        importMenu.modalPresentationStyle = .formSheet
//        importMenu.allowsMultipleSelection = false
//        self.present(importMenu, animated: true, completion: nil)
    }
}


extension ViewController: UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate{
    
//    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        guard let myURL = urls.first else {
//            return
//        }
//        print("import result : \(myURL)")
//    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
}
