//
//  BaseViewController.swift
//  Cognera
//
//  Created by DHEERAJ BHAVSAR on 08/06/19.
//  Copyright © 2019 Dheeraj Bhavsar. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var dialog: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Show Dialog
    func showDialog(title: String, actionTitle: String, message: String?) {
        dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialog!.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(dialog!, animated: true, completion: nil)
    }
    
    //MARK: Show dialog with completion handler
    func showDialog(title: String, actionTitle: String, message: String?, completion:((UIAlertAction) -> Void)?) {
        dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialog!.addAction(UIAlertAction(title: actionTitle, style: .default, handler: completion))
        dialog!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(dialog!, animated: true, completion: nil)
    }

}
