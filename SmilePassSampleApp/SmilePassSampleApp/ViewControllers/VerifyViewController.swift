//
//  VerifyViewController.swift
//  SmilePassSampleApp
//
//  Created by stplmacmini5 on 19/12/18.
//  Copyright © 2018 stplmacmini5. All rights reserved.
//

import UIKit

class VerifyViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var arrFieldData: [FieldDataModel]!
    
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
        arrFieldData = [FieldDataModel(key: SmilePassParameters.uniqueKey, value: nil, placeholder: "uniqueKey".localized()), FieldDataModel(key: SmilePassParameters.imageUrl, value: nil, placeholder: "imageUrl".localized())]
    }
    
    func getParams() -> [String: String] {
        var params = [String: String]()
        for data in arrFieldData {
            params[data.key] = data.value ?? ""
        }
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
    
    @IBAction func verifyButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        let param = getParams()
        self.showHideHUD(true)
        SmilePassManager.verify(with: param) { (response, errorMessage) in
            self.showHideHUD(false)
            if let message = errorMessage {
                self.showSmilePassMessage(message, isError: true)
            } else if let dict = response as? [String: Any] {
                if dict.getInt(forKey: SmilePassParameters.status) == 1 {
                    let confidenceScore = dict.getDouble(forKey: SmilePassParameters.confidenceScore)
                    let statusMessage = confidenceScore > SmilePassConstants.faceVerificationThreshold ? "faceVerified" : "faceVerificationFailed"
                    let message = String(format: statusMessage.localized(), confidenceScore)
                    self.showSmilePassMessage(message, isError: confidenceScore < SmilePassConstants.faceVerificationThreshold)
                } else if let message = dict[SmilePassParameters.message] as? String {
                    self.showSmilePassMessage(message, isError: true)
                }
            }
        }
    }
        
}
