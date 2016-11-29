//
//  PacketTunnelProvider.swift
//  PacketTunnel
//
//  Created by FTS-MAC-001 on 28/11/16.
//  Copyright © 2016 FTS-MAC-001. All rights reserved.
//

import NetworkExtension

class PacketTunnelProvider: NEPacketTunnelProvider {

	 func startTunnelWithOptions(options: [String : NSObject]?, completionHandler: (NSError?) -> Void) {
		// Add code here to start the process of connecting the tunnel.
	}

	 func stopTunnelWithReason(reason: NEProviderStopReason, completionHandler: () -> Void) {
		// Add code here to start the process of stopping the tunnel.
		completionHandler()
	}

	 func handleAppMessage(messageData: NSData, completionHandler: ((NSData?) -> Void)?) {
		// Add code here to handle the message.
		if let handler = completionHandler {
			handler(messageData)
		}
	}

	 func sleepWithCompletionHandler(completionHandler: () -> Void) {
		// Add code here to get ready to sleep.
		completionHandler()
	}

	override func wake() {
		// Add code here to wake up.
	}
}
