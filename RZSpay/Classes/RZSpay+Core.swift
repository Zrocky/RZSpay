//
//  RZSpay+Core.swift
//  RZSAPY2.0
//
//  Created by Zrocky on 2017/10/24.
//  Copyright © 2017年 zrocky. All rights reserved.
//

import Foundation

extension RZSpay {
    // MARK: - core
    struct core {
        static func save(datas: [[String: Any]]) {
            let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: RZSpayConfiguration.groupIdentifier)
            if let spayURL = groupURL?.appendingPathComponent(RZSpayConfiguration.coreFileName) {
                let writeDatas = datas as NSArray
                writeDatas.write(to: spayURL, atomically: true)
            }
        }
        
        static func remove() {
            let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: RZSpayConfiguration.groupIdentifier)
            if let spayURL = groupURL?.appendingPathComponent(RZSpayConfiguration.coreFileName) {
                do {
                    try FileManager.default.removeItem(at: spayURL)
                }catch let error {
                    print(error)
                }
            }
        }
        
        static func load() -> [[String: Any]]? {
            guard RZSpay.isInstallSapy() else { return nil }
            let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: RZSpayConfiguration.groupIdentifier)
            if let spayURL = groupURL?.appendingPathComponent(RZSpayConfiguration.coreFileName) {
                let core = NSArray(contentsOf: spayURL)
                return core as? [[String: Any]]
            }
            return nil
        }
    }
    
}
