//
//  StringExtension.swift
//  SmilePassSampleApp
//
//  Created by stplmacmini5 on 19/12/18.
//  Copyright © 2018 stplmacmini5. All rights reserved.
//

import Foundation

extension String {
    
    func localized(withComment comment: String = "") -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    
}
