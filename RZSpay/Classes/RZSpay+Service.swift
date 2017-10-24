//
//  RZSpay+Service.swift
//  RZSAPY2.0
//
//  Created by Zrocky on 2017/10/24.
//  Copyright © 2017年 zrocky. All rights reserved.
//

import Foundation

public extension RZSpay {
    // MARK: - Service
    public struct service {
        public static func save(service: String) {
            let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: RZSpayConfiguration.groupIdentifier)
            if let spayURL = groupURL?.appendingPathComponent(RZSpayConfiguration.serviceFileName) {
                do {
                    try service.write(to: spayURL, atomically: true, encoding: String.Encoding.utf8)
                }catch let error {
                    print(error)
                }
            }
        }
        
        public static func remove() {
            let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: RZSpayConfiguration.groupIdentifier)
            if let spayURL = groupURL?.appendingPathComponent(RZSpayConfiguration.serviceFileName) {
                do {
                    try FileManager.default.removeItem(at: spayURL)
                }catch let error {
                    print(error)
                }
            }
        }
        
        public static func load() -> String? {
            guard RZSpay.isInstallSapy() else { return nil }
            let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: RZSpayConfiguration.groupIdentifier)
            if let spayURL = groupURL?.appendingPathComponent(RZSpayConfiguration.serviceFileName) {
                do {
                    let service = try String(contentsOf: spayURL, encoding: String.Encoding.utf8)
                    return service
                }catch let error {
                    print(error)
                }
            }
            return nil
        }
    }
}
