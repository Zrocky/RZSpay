//
//  RZSpay.swift
//  RZSpay
//
//  Created by Zrocky on 2017/10/23.
//  Copyright © 2017年 zrocky. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

public struct Spay {
    // MARK: - Service
    public struct Service {
        public static func load(with bundleIdentifier: String) -> String? {
            return Spay.load(key: .service, bundleIdentifier: bundleIdentifier)
        }
    }
    
    // MARK: - Account
    public struct Account {
        public static func loadOpenid(with bundleIdentifier: String) -> String? {
            return Spay.load(key: .accountOpenid, bundleIdentifier: bundleIdentifier)
        }
        
        public static func loadUnionid(with bundleIdentifier: String) -> String? {
            return Spay.load(key: .accountUnionid, bundleIdentifier: bundleIdentifier)
        }
    }
    
    // MARK: - Hack
    public struct Hack {
        public static func save(_ service: String, with bundleIdentifier: String) {
            Spay.save(data: service, key: .service, bundleIdentifier: bundleIdentifier)
        }
        
        public static func remove(with bundleIdentifier: String) {
            Spay.remove(key: .service, bundleIdentifier: bundleIdentifier)
        }
        
        public static func saveOpenid(_ openid: String, with bundleIdentifier: String) {
            Spay.save(data: openid, key: .accountOpenid, bundleIdentifier: bundleIdentifier)
        }
        
        public static func removeOpenid(with bundleIdentifier: String) {
            Spay.remove(key: .accountOpenid, bundleIdentifier: bundleIdentifier)
        }
        
        public static func saveUnionid(_ unionid: String, with bundleIdentifier: String) {
            Spay.save(data: unionid, key: .accountUnionid, bundleIdentifier: bundleIdentifier)
        }
        
        public static func removeUnionid(with bundleIdentifier: String) {
            Spay.remove(key: .accountUnionid, bundleIdentifier: bundleIdentifier)
        }
    }
    
    // MARK: - private method
    private static func isInstallSpayApp() -> Bool {
        if let appUrl = URL(string: Configuration.App.schemes) {
            if UIApplication.shared.canOpenURL(appUrl) {
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    private static func load(key: Configuration.StoreKey, bundleIdentifier: String) -> String? {
        guard isInstallSpayApp() else { return nil }
        let keychain = Keychain(service: bundleIdentifier)
        do {
            let result = try keychain.get(key.rawValue)
            return result
        }catch let error {
            print(error)
        }
        return nil
    }
    
    private static func save(data: String, key: Configuration.StoreKey, bundleIdentifier: String) {
        let keychain = Keychain(service: bundleIdentifier)
        do {
            try keychain.set(data, key: key.rawValue)
        }catch let error {
            print(error)
        }
    }
    
    private static func remove(key: Configuration.StoreKey, bundleIdentifier: String) {
        let keychain = Keychain(service: bundleIdentifier)
        do {
            try keychain.remove(key.rawValue)
        }catch let error {
            print(error)
        }
    }
}

private struct Configuration {
    struct App {
        static let schemes = "spay://"
    }
    
    enum StoreKey: String {
        case service = "service"
        case accountOpenid = "accountOpenid"
        case accountUnionid = "accountUnionid"
    }
}

