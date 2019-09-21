//
//  UIViewController.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showLoader(completion: (() -> Void)? = nil){
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let rootViewController = appDelegate.window?.rootViewController,
                !(self.presentedViewController is UIAlertController) else { return }
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating();
            alert.view.addSubview(loadingIndicator)
            rootViewController.present(alert, animated: true, completion: completion)
        }
    }
    
    func hideLoader(completion: (() -> Void)? = nil){
        DispatchQueue.main.async {
             if let vc = self.presentedViewController, vc is UIAlertController {
                self.dismiss(animated: true, completion: completion)
            }
        }
    }
    
    func showAlertError(_ error: String) {
        DispatchQueue.main.async {
            [weak self] in
            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
