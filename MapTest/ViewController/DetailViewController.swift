//
//  DetailViewController.swift
//  MapTest
//
//  Created by zc on 2019/2/22.
//  Copyright © 2019 com.cozhang.demo. All rights reserved.
//

import UIKit
import SVGKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var svg: SVGKFastImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self
        configUI()
    }

    func configUI() {
        let svgImage = SVGKImage.init(named: SvgFile.china.rawValue)!
        svg = SVGKFastImageView(svgkImage: svgImage)
        scrollView.addSubview(svg)
        scrollView.contentSize = svg.frame.size
        scrollView.bounces=true;
        scrollView.decelerationRate=UIScrollView.DecelerationRate.fast;
        scrollView.isScrollEnabled=true;
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransformAnimatedDismiss()
    }
}
