//
//  MapParse.swift
//  MapTest
//
//  Created by zc on 2019/2/21.
//  Copyright © 2019 com.cozhang.demo. All rights reserved.
//

import UIKit

class MapParse: NSObject,XMLParserDelegate {
    
    var xmlParser: XMLParser!
    var dataArray: [MapModel] = []
    var currentValue: String!
    
    func parseMap(resource: String) {
        let path = Bundle.main.path(forResource: resource, ofType: "svg")!
        let mapData = NSData(contentsOfFile: path)!
        xmlParser = XMLParser(data: Data(referencing: mapData))
        xmlParser.delegate = self
        xmlParser.parse()
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue = string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "country-abbrev" {
            dataArray.append(MapModel(name: currentValue, peopleCount: 123442, GDP: "2233555"))
        }
    }
    
    func checkName(content: String) -> MapModel? {
        let result = dataArray.filter({ model -> Bool in
            return content.contains(model.name)
        })
        if result.count == 1 {
            return result[0]
        }
        return nil
    }
}
