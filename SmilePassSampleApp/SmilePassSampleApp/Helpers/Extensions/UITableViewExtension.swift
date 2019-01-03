//
//  UITableViewExtension.swift
//  SmilePassSampleApp
//
//  Created by stplmacmini5 on 19/12/18.
//  Copyright © 2018 stplmacmini5. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func reloadTableRow(at indexPath: IndexPath, with animation: UITableViewRowAnimation = .automatic) {
        DispatchQueue.main.async {
            self.beginUpdates()
            self.reloadRows(at: [indexPath], with: animation)
            self.endUpdates()
        }
    }
    
}
