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
/**
     TUTORIAL FROM THIS WEBSITE
     
     https://developer.apple.com/videos/play/wwdc2015/717/
     
     http://ramezanpour.net/post/2014/08/03/configure-and-manage-vpn-connections-programmatically-in-ios-8/
    
    */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }
/**
   - **NEVPNManager is the most important class in this framework. It’s responsible for load, save and remove preferences. In fact, all VPN tasks have to be done through this class.**
     
   - **After NEVPNManager is initialized, system preferences can be loaded using loadFromPreferencesWithCompletionHandler: method:**
 */
    @IBAction func connectWithVPN(_ sender: Any) {
        
    let manager = NEVPNManager.shared()
        manager.loadFromPreferences { (errorIs) in
            if (errorIs != nil){
              print("Somthing happened with loading preferences")
            }
            else{
                print("completed loading preferences")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

