//
//  secondalertvc.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/3/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class secondalertvc: CustomBaseViewVC {
    
    lazy var textView = UITextView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    func setup()  {
        let alertController = UIAlertController(title: "Feedback \n\n\n\n\n", message: nil, preferredStyle: .alert)

           let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
               alertController.view.removeObserver(self, forKeyPath: "bounds")
           }
           alertController.addAction(cancelAction)

           let saveAction = UIAlertAction(title: "Submit", style: .default) { (action) in
               let enteredText = self.textView.text
               alertController.view.removeObserver(self, forKeyPath: "bounds")
           }
           alertController.addAction(saveAction)

           alertController.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
           textView.backgroundColor = UIColor.white
           textView.textContainerInset = UIEdgeInsets.init(top: 8, left: 5, bottom: 8, right: 5)
           alertController.view.addSubview(self.textView)

           self.present(alertController, animated: true, completion: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds"{
            if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
                let margin: CGFloat = 8
                let xPos = rect.origin.x + margin
                let yPos = rect.origin.y + 54
                let width = rect.width - 2 * margin
                let height: CGFloat = 90

                textView.frame = CGRect.init(x: xPos, y: yPos, width: width, height: height)
            }
        }
    }
}
