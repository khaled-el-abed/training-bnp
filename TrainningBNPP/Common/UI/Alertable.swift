//
//  Alertable.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 23/06/2022.
//

import UIKit

protocol Alertable {
    func showAlert(with title: String, message: String, buttonTitle: String?, completion: (() -> Void)? )
    func showError(_ error: BnpError, completion: (() -> Void)? )
}

extension Alertable where Self: UIViewController {

    func showAlert(with title: String, message: String, buttonTitle: String? = nil , completion: (() -> Void)? = nil) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle ?? "Ok", style: .default, handler: { (action) -> Void in
            completion?()
         })

        dialogMessage.addAction(ok)
        present(dialogMessage, animated :true)
    }
    
    func showError(_ error: BnpError, completion: (() -> Void)? = nil) {
        showAlert(with: error.title, message: error.description, buttonTitle: "Ok", completion: completion)
    }
}
