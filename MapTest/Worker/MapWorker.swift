//
//  MapWorker.swift
//  MapTest
//
//  Created by zc on 2019/2/21.
//  Copyright © 2019 com.cozhang.demo. All rights reserved.
//

import UIKit
import SVGKit

enum SvgFile: String {
    case china = "cn-all.svg"
    case world = "world.svg"
}

class MapWorker {
    
    func zoomSize(svg: SVGKFastImageView) -> CGSize {
        return CGSize(width: svg.bounds.size.width/svg.image.size.width, height: svg.bounds.size.height/svg.image.size.height)
    }
    
    func zoomRate(svg: SVGKFastImageView) -> CGFloat {
        return max(svg.bounds.size.width/svg.image.size.width, svg.bounds.size.height/svg.image.size.height)
    }
    
    func getHitedElementOfLayer(hitedLayer: CALayer, svg: SVGKFastImageView) -> Element? {
        let svgImage = svg.image!
        let dom = svgImage.domDocument
        let xmlTagID = hitedLayer.value(forKey: kSVGElementIdentifier) as! String
        return dom?.getElementById(xmlTagID)
    }
}
