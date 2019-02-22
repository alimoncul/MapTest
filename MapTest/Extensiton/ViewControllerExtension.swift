//
//  ViewControllerExtension.swift
//  MapTest
//
//  Created by zc on 2019/2/22.
//  Copyright © 2019 com.cozhang.demo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showToast(model: MapModel, isShowOther: Bool = false) {
        let toast = ToastView.loadFromNib()
        view.addSubview(toast)
        toast.translatesAutoresizingMaskIntoConstraints = false
        toast.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toast.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        if isShowOther {
            toast.textLable.text = "name: \(model.name)\npeopleCount: \(model.peopleCount)\nGDP: \(model.GDP)"
        } else {
            toast.textLable.text = "name: \(model.name)"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) { [weak toast] in
            if let toastView = toast {
                toastView.removeFromSuperview()
            }
        }
    }
}
