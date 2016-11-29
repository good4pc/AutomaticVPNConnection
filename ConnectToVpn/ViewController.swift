//
//  ViewController.swift
//  ConnectToVpn
//
//  Created by FTS-MAC-001 on 23/11/16.
//  Copyright © 2016 FTS-MAC-001. All rights reserved.
//

import UIKit
import  NetworkExtension


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        savingToPreferences()
    }
/**
     This project is based on the reference from this site
     
    https://developer.apple.com/videos/play/wwdc2015/717/
     
     http://ramezanpour.net/post/2014/08/03/configure-and-manage-vpn-connections-programmatically-in-ios-8/
     
   - **NEVPNManager is the most important class in this framework. It’s responsible for load, save and remove preferences. In fact, all VPN tasks have to be done through this class.**
     
   - **After NEVPNManager is initialized, system preferences can be loaded using loadFromPreferencesWithCompletionHandler: method:**
 */
    func savingToPreferences(){
        let manager = NEVPNManager.shared()
        manager.loadFromPreferences { (errorIs) in
            if (errorIs != nil){
                print("Something happened with loading preferences")
            }
            else{
                print("completed loading preferences")
            }
        }
        
        saveUsernameToKeychaing()
        
        
        let ipSec = NEVPNProtocolIPSec.init()
        ipSec.username = "mobile"
        ipSec.passwordReference = Data()// [VPN user password from keychain]
        ipSec.serverAddress = "" //[Your server address]
        ipSec.authenticationMethod = NEVPNIKEAuthenticationMethod.sharedSecret
        ipSec.sharedSecretReference = Data()//[VPN server shared secret from keychain];
        ipSec.localIdentifier = "VPN local identifier"
        ipSec.remoteIdentifier = "VPN remote identifier"
        ipSec.useExtendedAuthentication = true
        ipSec.disconnectOnSleep = false
        
        
        manager.protocolConfiguration = ipSec
        manager.isOnDemandEnabled = false
        manager.localizedDescription = "Our Vpn Configuration Name"
        
        manager.saveToPreferences { (errorHappenedHere) in
            if errorHappenedHere != nil{
                print("Error happened here is \(errorHappenedHere)")
            }else{
                print("saved to preference is successful")
            }
        }
     }
    //MARK:- Converting vpn username to Data
    /**
     http://ramezanpour.net/post/2014/09/26/how-to-get-persistent-references-to-keychain-items-in-ios/
 */
    func saveUsernameToKeychaing(){
        let service : String = "ServiceName"
        let password : String = "password"
        let passWordData = password.data(using: .utf8)
        
        let dictionary = NSMutableDictionary()
        dictionary.setObject(kSecClassGenericPassword, forKey: kSecClass as! NSCopying)
        let encodedKey = "someKey".data(using: .utf8)
        dictionary.setObject(encodedKey, forKey: kSecAttrGeneric as! NSCopying)
        dictionary.setObject(encodedKey, forKey: kSecAttrAccount as! NSCopying)
        dictionary.setObject(service, forKey: kSecAttrService as! NSCopying)
        dictionary.setObject(kSecAttrAccessibleAlwaysThisDeviceOnly, forKey: kSecAttrAccessible as! NSCopying)
        dictionary.setObject(passWordData, forKey: kSecValueData as! NSCopying)
        
        
        var status : OSStatus =  SecItemAdd(dictionary, nil)
      print(status)
        
        
    }
    func getPasswordWithPersistentReference(_ persistentReference: Data) -> String? {
        var result: String?
        let query: [NSObject: AnyObject] = [
            kSecClass : kSecClassGenericPassword,
            kSecReturnData : kCFBooleanTrue,
            kSecValuePersistentRef : persistentReference as AnyObject
        ]
        
        var returnValue: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &returnValue)
        
        if let passwordData = returnValue as? Data , status == errSecSuccess {
            result = NSString(data: passwordData, encoding: String.Encoding.utf8.rawValue) as? String
        }
        return result
    }
    @IBAction func connectWithVPN(_ sender: Any) {
        do{
            try NEVPNManager.shared().connection.startVPNTunnel()
        }
        catch  let error as Error{
            
            print("something happened here while start vpn tunnel with error \(error.localizedDescription)")
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

