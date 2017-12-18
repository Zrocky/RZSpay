//
//  RZSpay+Service.swift
//  RZSAPY2.0
//
//  Created by Zrocky on 2017/10/24.
//  Copyright © 2017年 zrocky. All rights reserved.
//

import Foundation
import KeychainAccess

public extension RZSpay {
    // MARK: - Service
    public struct service {
        public static func save(service: String, bundleIdentifier: String) {
            let keychain = Keychain(service: bundleIdentifier)
            do {
                try keychain.set(service, key: RZSpayConfiguration.spayService)
            }catch let error {
                print(error)
            }
        }
        
        public static func remove(bundleIdentifier: String) {
            let keychain = Keychain(service: bundleIdentifier)
            do {
                try keychain.remove(RZSpayConfiguration.spayService)
            }catch let error {
                print(error)
            }
        }
        
        public static func load(bundleIdentifier: String) -> String? {
            guard RZSpay.isInstallSapy() else { return nil }
            let keychain = Keychain(service: bundleIdentifier)
            do {
                let service = try keychain.get(RZSpayConfiguration.spayService)
                return service
            }catch let error {
                print(error)
            }
            return nil
        }
    }
}
