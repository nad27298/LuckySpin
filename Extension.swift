//
//  Extension.swift
//  RotationLucky
//
//  Created by Macbook on 2/5/21.
//

import Foundation
import UIKit
import Toast_Swift

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
    
    func counter(assets: [[Any]]) -> Int{
        var count = 0
        for assets in assets{
            if assets.count > 1{
                count = count + assets.count - 1
            }
        }
        return count
    }
    
    func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}

extension UIViewController {
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func showMessage(_ message: String) {
        var style = ToastStyle()
        style.messageColor = .black
        style.backgroundColor = .green
        self.view.makeToast(message, duration: 3.0, position: .bottom, style: style)
    }
    
    func showError(_ message: String) {
        var style = ToastStyle()
        style.messageColor = .black
        style.backgroundColor = .red
        self.view.makeToast(message, duration: 3.0, position: .top, style: style)
    }
}
