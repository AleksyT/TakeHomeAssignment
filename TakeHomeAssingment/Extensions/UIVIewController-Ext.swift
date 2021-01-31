//
//  UIVIewController-Ext.swift
//  TakeHomeAssingment
//
//  Created by Aleksy Tylkowski on 29/01/2021.
//

import UIKit

private func _swizzling(forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    if let originalMethod = class_getInstanceMethod(forClass, originalSelector),
       let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

extension UIViewController {
    static let preventPageSheetPresentation: Void = {
            if #available(iOS 13, *) {
                _swizzling(forClass: UIViewController.self,
                           originalSelector: #selector(present(_: animated: completion:)),
                           swizzledSelector: #selector(_swizzledPresent(_: animated: completion:)))
            }
        }()

        @available(iOS 13.0, *)
        @objc private func _swizzledPresent(_ viewControllerToPresent: UIViewController,
                                            animated flag: Bool,
                                            completion: (() -> Void)? = nil) {
            if viewControllerToPresent.modalPresentationStyle == .pageSheet
                       || viewControllerToPresent.modalPresentationStyle == .automatic {
                viewControllerToPresent.modalPresentationStyle = .fullScreen
            }
            _swizzledPresent(viewControllerToPresent, animated: flag, completion: completion)
        }
}
