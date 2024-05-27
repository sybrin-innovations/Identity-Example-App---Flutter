import UIKit
import Flutter
import Sybrin_iOS_Identity
import Sybrin_iOS_Biometrics

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    let licenseKey: String = ""
    
    let biometricLicenseKey = ""
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      let sybrinConfig = SybrinIdentityConfiguration(license: licenseKey)
      sybrinConfig.language = .ENGLISH
      SybrinIdentity.shared.configuration = sybrinConfig
      SybrinIdentity.shared.changeLogLevel(to: .Information)
      
    //   let sybrinBiometricsConfig = SybrinBiometricsConfiguration(license: biometricLicenseKey)
    //   sybrinBiometricsConfig.language = .ENGLISH
    //   SybrinBiometrics.shared.configuration = sybrinBiometricsConfig
    //   SybrinBiometrics.shared.changeLogLevel(to: .Information)
      
      
      identiftySetup()
    //   biometricsSetup()
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func identiftySetup() {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannelName = "com.example.myTestApp/scanDocument"
        let scanDocChannel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: controller.binaryMessenger)
        
        scanDocChannel.setMethodCallHandler({
            [self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "scanID":
                scanIDCard(controller: controller) {
                    (res, hasError) in
                    result(res)
                }
            case "scanPassport":
                scanPassport(controller: controller)
            case "scanDriversLicense":
                scanLicense(controller: controller)
            default:
                result(FlutterMethodNotImplemented)
            }
        })
    }
    
    // func biometricsSetup() {
    //     let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    //     let methodChannelName = "com.example.myTestApp/passiveLiveness"
    //     let passiveLivenessChannel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: controller.binaryMessenger)
        
    //     passiveLivenessChannel.setMethodCallHandler({
    //         [self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
    //         switch call.method {
    //         case "passiveLiveness":
    //             passiveLivenessScan(controller: controller) {
    //                 res in
    //                 result(res)
    //             }
    //         default:
    //             result(FlutterMethodNotImplemented)
    //         }
    //     })
    // }
    
    private func scanIDCard(controller: FlutterViewController, completion: @escaping (String, Bool?) -> Void) {
            
        SybrinIdentity.shared.scanIDCard(on: controller, for: .Philippines) { (result, message) in
                
                print("Done Launching: \(result) \(!result ? "with message: \(message ?? "")" : "")")
                if let message = message { self.showToast(controller: controller, message: message) }
                
            } success: { (model) in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                    if let identityNumber = model.identityNumber { self.showToast(controller: controller, message: "Scanned ID Card for \(identityNumber)") }
                    
                    let json:  [String: Any] = [
                        "fullName": model.fullName ?? "",
                        "dateOfBirth": model.dateOfBirth ?? Date(),
                        "identityNumber": model.identityNumber ?? "",
                        "nationality": model.nationality ?? "",
                        "sex": model.sex.stringValue
                    ]
                    
                    let jsonString = (json.compactMap({ (key, value) -> String in
                        return "\(key)=\(value)"
                    }) as Array).joined(separator: ";")
                    
                    completion(jsonString, nil)
                    
                }
                
            } failure: { (message) in
                
                print("Scan ID Card Failed: \(message)")
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                    self.showToast(controller: controller, message: message)
                }
                
            } cancel: {
                
                print("Scan ID Card Canceled")
        }

    }
    
    private func scanPassport(controller: FlutterViewController) {
            
        SybrinIdentity.shared.scanPassport(on: controller, for: .Philippines) {
            (result, message) in
        }
        success: { (model) in
            
        }
        failure: { (message) in
            
        }
        
        cancel: {
            
        }

    }
    
    private func scanLicense(controller: FlutterViewController) {
            
        SybrinIdentity.shared.scanDriversLicense(on: controller, for: .Philippines) {
            (result, message) in
        }
        success: { (model) in
            
        }
        failure: { (message) in
            
        }
        
        cancel: {
            
        }

    }
    
    // private func passiveLivenessScan(controller: FlutterViewController, completion: @escaping (String) -> Void ) {
    //     SybrinBiometrics.shared.openPassiveLivenessDetection(on: controller) {
    //         (result, message) in
            
    //         completion("done")
    //     }
    //     success: { (model) in}
    //     failure: { err_ in}
    //     cancel: { }
    // }
    
    
    func showToast(controller: UIViewController, message : String) {
           DispatchQueue.main.async {
               // Removing the toast container
               if let viewToRemove = controller.view.viewWithTag(100) {
                   viewToRemove.removeFromSuperview()
               }
               
               // Creating the taost container
               let toastContainer = UIView(frame: CGRect())
               toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
               toastContainer.alpha = 0.0
               toastContainer.layer.cornerRadius = 25;
               toastContainer.clipsToBounds  =  true
               toastContainer.tag = 100
               
               let toastLabel = UILabel(frame: CGRect())
               toastLabel.textColor = UIColor.white
               toastLabel.textAlignment = .center;
               toastLabel.font.withSize(12.0)
               toastLabel.text = message
               toastLabel.clipsToBounds  =  true
               toastLabel.numberOfLines = 0
               
               toastContainer.addSubview(toastLabel)
               controller.view.addSubview(toastContainer)
               
               toastLabel.translatesAutoresizingMaskIntoConstraints = false
               toastContainer.translatesAutoresizingMaskIntoConstraints = false
               
               let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
               let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
               let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
               let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
               toastContainer.addConstraints([a1, a2, a3, a4])
               
               let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 65)
               let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -65)
               let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -75)
               controller.view.addConstraints([c1, c2, c3])
               
               UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                   toastContainer.alpha = 1.0
               }, completion: { _ in
                   UIView.animate(withDuration: 0.5, delay: 3, options: .curveEaseOut, animations: {
                       toastContainer.alpha = 0.0
                   }, completion: {_ in
                       toastContainer.removeFromSuperview()
                   })
               })
           }
       }
}

struct JSONStringEncoder {
    /**
     Encodes a dictionary into a JSON string.
     - parameter dictionary: Dictionary to use to encode JSON string.
     - returns: A JSON string. `nil`, when encoding failed.
     */
    func encode(_ dictionary: [String: Any]) -> String? {
        guard JSONSerialization.isValidJSONObject(dictionary) else {
            assertionFailure("Invalid json object received.")
            return nil
        }

        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        let jsonData: Data

        dictionary.forEach { (arg) in
            jsonObject.setValue(arg.value, forKey: arg.key)
        }

        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        } catch {
            assertionFailure("JSON data creation failed with error: \(error).")
            return nil
        }

        guard let jsonString = String.init(data: jsonData, encoding: String.Encoding.utf8) else {
            assertionFailure("JSON string creation failed.")
            return nil
        }

        print("JSON string: \(jsonString)")
        return jsonString
    }
}
