//
//  MapModel.swift
//  MapTest
//
//  Created by zc on 2019/2/21.
//  Copyright © 2019 com.cozhang.demo. All rights reserved.
//

import Foundation

struct MapModel {
    let name: String
    let peopleCount: Int
    let GDP: String
    
    init(name: String, peopleCount: Int, GDP: String) {
        self.name = name
        self.peopleCount = peopleCount
        self.GDP = GDP
    }
}
