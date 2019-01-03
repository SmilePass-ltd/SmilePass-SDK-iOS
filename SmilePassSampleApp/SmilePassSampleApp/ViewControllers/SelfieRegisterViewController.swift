//
//  SelfieRegisterViewController.swift
//  SmilePassSampleApp
//
//  Created by stplmacmini5 on 19/12/18.
//  Copyright © 2018 stplmacmini5. All rights reserved.
//

import UIKit

class SelfieRegisterViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!

    var arrFieldData: [FieldDataModel]!
    var uniqueKey: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initialSetup() {
        prepareArray()
        tableView.dataSource = self
    }

    fileprivate func prepareArray() {
        arrFieldData = [FieldDataModel(key: SmilePassParameters.uniqueKey, value: uniqueKey, placeholder: "uniqueKey".localized()), FieldDataModel(key: SmilePassParameters.callbackUrl, value: nil, placeholder: "callbackUrl".localized()), FieldDataModel(key: SmilePassParameters.imageUrls, value: nil, placeholder: "imageUrl".localized()), FieldDataModel(key: SmilePassParameters.imageUrls, value: nil, placeholder: "imageUrl".localized())]
    }
    
    func getParams() -> [String: Any] {
        var params = [String: Any]()
        var imageUrls = [String]()
        for data in arrFieldData {
            if data.key == SmilePassParameters.imageUrls {
                let imageUrl = data.value ?? ""
                if imageUrl.count > 0 {
                    imageUrls.append(imageUrl)
                }
            } else {
                params[data.key] = data.value ?? ""
            }
        }
        params[SmilePassParameters.imageUrls] = imageUrls
        params[SmilePassParameters.step] = SmilePassParameters.selfie
        return params
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if arrFieldData.indices.contains(textField.tag) {
            arrFieldData[textField.tag].value = textField.text
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFieldData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.textFieldCell) as! TextFieldCell
        let data = arrFieldData[indexPath.row]
        cell.textField.placeholder = data.placeholder
        cell.textField.text = data.value
        cell.textField.delegate = self
        cell.textField.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - Button Actions
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        let param = getParams()
        self.showHideHUD(true)
        SmilePassManager.register(with: param) { (response, errorMessage) in
            self.showHideHUD(false)
            if let message = errorMessage {
                self.showSmilePassMessage(message, isError: true)
            } else if let dict = response as? [String: Any] {
                if let message = dict[SmilePassParameters.message] as? String {
                    self.showAlert(with: "success".localized(), message: message, buttons: ["ok".localized()], tapped: { (buttonTitle) in
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                }
            }
        }
    }

}
