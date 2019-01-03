//
//  WelcomeViewController.swift
//  SmilePassSampleApp
//
//  Created by stplmacmini5 on 19/12/18.
//  Copyright © 2018 stplmacmini5. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Actions
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        showAlert(with: "registrationType".localized(), message: "documentAlert".localized(), buttons: ["yes".localized(), "no".localized()]) { (selectedButtonTitle) in
            let segueName = selectedButtonTitle == "yes".localized() ? SegueName.documentRegister : SegueName.selfieRegister
            self.performSegue(withIdentifier: segueName, sender: nil)
        }
    }
    

}
