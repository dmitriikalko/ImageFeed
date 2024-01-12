//
//  UIBlockingProgressHUD.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 13.01.2024.
//

import Foundation
import UIKit
import ProgressHUD

final class UIBlockingProgressHUD {
    
    //MARK: static properties
    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    
    //MARK: static metods
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.show()
    }
    
    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}
