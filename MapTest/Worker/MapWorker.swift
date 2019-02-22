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
    
    func changeMapColor(svg: SVGKFastImageView) {
        let nodeList = svg.image.domDocument.getElementsByTagName("path")!
        let colors = createAllColor(count: Int(nodeList.length))
        for i in 0...nodeList.length-1 {
            let pathNode = (nodeList.item(i) as! SVGPathElement)
            pathNode.setAttributeNS("fill", qualifiedName: "fill", value: colors[Int(i)].toHexString)
        }
    }
    
    private func createAllColor(count: Int) -> [UIColor] {
        var green = 1.0
        var colorArr:[UIColor] = []
        for _ in 0..<count {
            green = green + 10.0
            if Int(green) > 255 {
                green = 1.0
            }
            let color = UIColor(red: 20.0/255, green: CGFloat(green / 255), blue: 187.0/255, alpha: 1.0)
            colorArr.append(color)
        }
        return colorArr
    }
}
