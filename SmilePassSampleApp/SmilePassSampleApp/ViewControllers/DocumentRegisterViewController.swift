//
//  DocumentRegisterViewController.swift
//  SmilePassSampleApp
//
//  Created by stplmacmini5 on 19/12/18.
//  Copyright © 2018 stplmacmini5. All rights reserved.
//

import UIKit

class DocumentRegisterViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewPickerView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let kDocumentFieldTag = 1
    
    var arrFieldData: [FieldDataModel]!
    let pickerData: [SmilePassDocumentType] = [.drivingLicense, .passport]
    
    
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
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    fileprivate func prepareArray() {
        arrFieldData = [FieldDataModel(key: SmilePassParameters.uniqueKey, value: nil, placeholder: "uniqueKey".localized()), FieldDataModel(key: SmilePassParameters.documentId, value: SmilePassDocumentType.drivingLicense.rawValue, placeholder: "documentId".localized()), FieldDataModel(key: SmilePassParameters.frontImageUrl, value: nil, placeholder: "frontImageUrl".localized()), FieldDataModel(key: SmilePassParameters.backImageUrl, value: nil, placeholder: "backImageUrl".localized())]
    }
    
    func getParams() -> [String: String] {
        var params = [String: String]()
        for data in arrFieldData {
            params[data.key] = data.value ?? ""
        }
        params[SmilePassParameters.step] = SmilePassParameters.document
        return params
    }
 
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if arrFieldData.indices.contains(textField.tag) {
            if textField.tag == kDocumentFieldTag {
                arrFieldData[textField.tag].value = pickerData[pickerView.selectedRow(inComponent: 0)].rawValue
                tableView.reloadTableRow(at: IndexPath(row: textField.tag, section: 0))
            } else {
                arrFieldData[textField.tag].value = textField.text
            }
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
        if data.key == SmilePassParameters.documentId, let documentId = data.value {
            cell.textField.inputView = viewPickerView
            cell.textField.text = (SmilePassDocumentType(rawValue: documentId) ?? .drivingLicense).name()
        } else {
            cell.textField.text = data.value
            cell.textField.inputView = nil
        }
        cell.textField.delegate = self
        cell.textField.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].name()
    }
    
    // MARK: - Button Actions
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        let params = getParams()
        self.showHideHUD(true)
        SmilePassManager.register(with: params) { (response, errorMessage) in
            self.showHideHUD(false)
            if let message = errorMessage {
                self.showSmilePassMessage(message, isError: true)
            } else if let dict = response as? [String: Any] {
                if dict.getInt(forKey: SmilePassParameters.status) == 1 {
                    self.performSegue(withIdentifier: SegueName.documentToSelfie, sender: params[SmilePassParameters.uniqueKey])
                } else if let message = dict[SmilePassParameters.message] as? String {
                    self.showSmilePassMessage(message, isError: false)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? SelfieRegisterViewController {
            destinationVC.uniqueKey = sender as? String
        }
    }

}
