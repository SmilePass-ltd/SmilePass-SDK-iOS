//
//  UIViewControllerExtension.swift
//  SmilePassSampleApp
//
//  Created by stplmacmini5 on 19/12/18.
//  Copyright © 2018 stplmacmini5. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    private static let indicatorTag = 1993
    
    func showAlert(with title: String? = nil, message: String? = nil, buttons: [String], tapped: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for buttonTitle in buttons {
            alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
                tapped(buttonTitle)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showSmilePassMessage(_ message: String, isError: Bool) {
        showAlert(with: (isError ? "error" : "success").localized(), message: message, buttons: ["ok".localized()]) { (selectedButtonTitle) in
        }
    }
    
    func showHideHUD(_ show: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = show
            self.hideHUD()
            if show {
                self.showHUD()
            }
        }
    }
    
    fileprivate func showHUD() {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.tag = (UIViewController.indicatorTag)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    fileprivate func hideHUD() {
        if let activityIndicator = self.view.viewWithTag(UIViewController.indicatorTag) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
}
