//
//  ToastView.swift
//  MapTest
//
//  Created by zc on 2019/2/22.
//  Copyright © 2019 com.cozhang.demo. All rights reserved.
//

import UIKit

class ToastView: UIView {
    @IBOutlet weak var textLable: UILabel!
    
    static func loadFromNib() -> ToastView {
        let view = Bundle.main.loadNibNamed("ToastView", owner: self, options: nil)!.first as! ToastView
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }
}
