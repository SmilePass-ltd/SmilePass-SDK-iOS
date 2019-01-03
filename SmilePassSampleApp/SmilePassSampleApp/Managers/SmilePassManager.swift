//
//  SmilePassManager.swift
//  SmilePassSampleApp
//
//  Created by stplmacmini5 on 19/12/18.
//  Copyright © 2018 stplmacmini5. All rights reserved.
//

import UIKit
import SmilePass

class SmilePassManager: NSObject {
    
    static let shared = SmilePassManager()
    var smilePassObject: SmilePassClient?
    
    override init() {
        super.init()
        do {
            smilePassObject = try SmilePassClient(apiKey: SmilePassConstants.apiKey)
        } catch ClientException.invalidAPIKeyError {
            print("API key should not be blank")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func register(with param: [String: Any], completion: @escaping SmilePassCompletion) {
        shared.smilePassObject?.register(parameters: param, completion: { (response, smilePassError) in
            if let error = smilePassError {
                print("error -> \(String(describing: error))")
                completion(response, error.errorMessage)
            } else {
                print("response -> \(String(describing: response))")
                completion(response, nil)
            }
        })
    }
    
    static func verify(with param: [String: Any], completion: @escaping SmilePassCompletion) {
        shared.smilePassObject?.verify(parameters: param, completion: { (response, smilePassError) in
            if let error = smilePassError {
                print("error -> \(String(describing: error))")
                completion(response, error.errorMessage)
            } else {
                print("response -> \(String(describing: response))")
                completion(response, nil)
            }
        })
    }
    
}


struct SmilePassParameters {
    static let step = "step"
    static let uniqueKey = "uniqueKey"
    static let documentId = "documentId"
    static let callbackUrl = "callbackUrl"
    static let frontImageUrl = "frontImageUrl"
    static let backImageUrl = "backImageUrl"
    static let imageUrls = "imageUrls"
    static let imageUrl = "imageUrl"
    
    static let document = "document"
    static let selfie = "selfie"
    
    static let message = "message"
    static let status = "status"
    static let confidenceScore = "confidenceScore"
}

struct SmilePassConstants {
    static let apiKey = ""
    static let callbackUrl = ""
    
    static let faceVerificationThreshold: Double = 0.6
}

enum SmilePassDocumentType: String {
    case drivingLicense = "3"

    func name() -> String {
        return "\(self)".localized()
    }
}


