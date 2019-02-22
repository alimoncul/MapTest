//
//  MapViewController.swift
//  MapTest
//
//  Created by zc on 2019/2/20.
//  Copyright © 2019 com.cozhang.demo. All rights reserved.
//

import UIKit
import SVGKit
class MapViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var svg: SVGKFastImageView!
    var tapGesture: UITapGestureRecognizer!
    var mapWorker = MapWorker()
    var mapParse = MapParse()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapParse.parseMap(resource: "world")
        configUI()
        initEvent()
//        let nodeList = svg.image.domDocument.getElementsByTagName("path")!
//        for i in 0...nodeList.length-1 {
//            let childNodes = (nodeList.item(i) as! SVGElement).childNodes
//            if childNodes?.length ?? 0 > UInt(0) {
//                let aaa = childNodes!.item(0)?.childNodes
//            }
//            let color = "#"+UIColor.green.toHexString
//            //            startPoint.setAttribute("fill", value:"6E6E6E")
//        }
    }

    
    func configUI() {
        let svgImage = SVGKImage.init(named: SvgFile.world.rawValue)!
        svg = SVGKFastImageView(svgkImage: svgImage)
        scrollView.addSubview(svg)
        scrollView.contentSize = svg.frame.size
        scrollView.bounces=true;
        scrollView.decelerationRate=UIScrollView.DecelerationRate.fast;
        scrollView.isScrollEnabled=true;
    }
    
    private func initEvent() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        svg.addGestureRecognizer(tapGesture)
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        svg.addGestureRecognizer(longTap)
        
    }
    
    @objc private func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.began {
            let hitPoint = recognizer.location(in: svg)
            getTapLocationShowToast(point: hitPoint, isLongPress: true)
        }
    }
    
    @objc private func handleTapGesture(recognizer: UITapGestureRecognizer) {
        let hitPoint = recognizer.location(in: svg)
        getTapLocationShowToast(point: hitPoint, isLongPress: false)
    }
    
    func getTapLocationShowToast(point: CGPoint, isLongPress: Bool) {
        var hitPoint = point
        let svgLayer = svg.image.caLayerTree
        
        hitPoint = hitPoint.applying(CGAffineTransform(scaleX: mapWorker.zoomSize(svg: svg).width, y: mapWorker.zoomSize(svg: svg).height).inverted());
        if let hitLayer = svgLayer?.hitTest(hitPoint) {
            let copyHitLayer = svg.image?.newCopyPositionedAbsolute(of: hitLayer)
            
            if let lastElement = mapWorker.getHitedElementOfLayer(hitedLayer: copyHitLayer!, svg: svg) {
                if let model = mapParse.checkName(content: String(lastElement.textContent)) {
                    if model.name == "China" {
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                        vc.modalPresentationStyle = .custom
                        vc.transitioningDelegate = self
                        present(vc, animated: true, completion: nil)
                    } else {
                        isLongPress ? showToast(model: model, isShowOther: true) : showToast(model: model)
                    }
                }
            }
        }
    }
}

extension MapViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransformAnimationPresent()
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentation = MapPresentation(presentedViewController: presented, presenting: presenting)
        return presentation
    }
}
