//
//  RZSpayTool.swift
//  RZSAPY2.0
//
//  Created by Zrocky on 2017/10/23.
//  Copyright © 2017年 zrocky. All rights reserved.
//

import UIKit

public class RZSpay {
    // MARK: - private methods
    static func isInstallSapy() -> Bool {
        if let appUrl = URL(string: RZSpayConfiguration.spaySchemes) {
            if UIApplication.shared.canOpenURL(appUrl) {
                return true
            } else {
                return false
            }
        }
        return true
    }
}
