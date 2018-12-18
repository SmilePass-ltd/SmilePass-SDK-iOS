# SmilePass iOS SDK

## Introduction
SmilePass is a face verification SDK for iOS. This repo is the sample which demonstrate how to use SmilePass SDK in your iOS applications.
Using SmilePass, our clients can create unique and secure biometric profiles for each of their customers as they begin their journey together. Any future transactions or events that contain risk are verified against this profile.

**Our scalable security solution can be used to:**
* Provide frictionless and secure KYC for your customers
* Build trusted membership communities through identity management
* Reduce ticket, tout and payment fraud while increasing security
* Increase defences against fraudulent transactions and requests in a cost-effective way
* Streamline access to services without the need for hardware

SmilePass iOS SDK is available for iOS 11 and above.

## Get Started

This guide is a quick start to add SmilePass biometric verification to an iOS application.


## Prerequisites

### SmilePass API key
Your application needs an API key to access the features of SmilePass SDK. You can use it with any of your applications that use SmilePass Mobile SDKs and Cloud APIs. It supports an unlimited number of users.
To get API Key, [Contact SmilePass](https://smile-pass.com/contact).


## Add SmilePass to your application

### Step 1. Add SmilePass dependency
Add the following to your Podfile (inside the target section):
   
   `pod 'SmilePass'`

then run 

   `pod install`

### Step 2. Instantiate SmilePass client
Create an instance of SmilePass rest client and pass API Key as follows:

`let smilePassObject = SmilePassClient(apiKey: "API_KEY")`

### Step 3. Handle ClientException
You need to handle ClientException for creating an instance and calling any method of SmilePass
    
    do {
        let smilePassObject = try SmilePassClient(apiKey: "")
    } catch ClientException.invalidAPIKeyError {
        print("API key should not be blank")
    } catch let error {
            print(error.localizedDescription)
    }

**Exception**

This method will throw an exception `ClientException.invalidAPIKeyError` if the API key is passed as blank.

### Step 4. Access feature methods
The methods of SmilePass can be accessed using the instance of `SmilePassClient`. For example-

    smilePassObject?.register(parameters: dict, completion: { (response, smilePassError) in
        if smilePassError != nil {
            print("Error Code - \(smilePassError?.errorCode ?? "") Error Message - \(smilePassError?.errorMessage ?? "") User Info - \(smilePassError?.userInfo ?? ["": ""])")
        } else {
            if let resp = response as? [String: Any] {
                print(resp)
            }
        }
    })

this method takes `[String: Any]` as argument and in response handler give 2 objects `response` and `smilePassError`

`response` gives JSON and `smilePassError` is a custom error object.

For more details please visit our [wiki](https://github.com/SmilePass-ltd/SmilePass-SDK-iOS/wiki/SmilePass-Tutorials)

You are all set to use cutting-edge face verification features of the SmilePass. 

## Documents
For the detailed information on how to register and verify a user using SmilePass, read our detailed documents-
* [SDK Setup](https://github.com/SmilePass-ltd/SmilePass-SDK-iOS/wiki/SmilePass-SDK-Setup)
* [SmilePass Tutorials](https://github.com/SmilePass-ltd/SmilePass-SDK-iOS/wiki/SmilePass-Tutorials)
* [Troubleshooting](https://github.com/SmilePass-ltd/SmilePass-SDK-iOS/wiki/Troubleshooting)


## License
SmilePass iOS SDK sample application is licensed with the SmilePass License. For more details, see [LICENSE](https://smile-pass.com).
