//
//  MapPresentation.swift
//  MapTest
//
//  Created by zc on 2019/2/22.
//  Copyright © 2019 com.cozhang.demo. All rights reserved.
//

import UIKit

class MapPresentation: UIPresentationController {
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    private lazy var bgView: UIView = {
        let view = UIView(frame: self.containerView!.bounds)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override func presentationTransitionWillBegin() {
        containerView!.addSubview(bgView)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            bgView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            bgView.removeFromSuperview()
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let screenBound = UIScreen.main.bounds
        return CGRect(x: 0, y: 0, width: screenBound.size.width, height: screenBound.size.height)
    }
}
