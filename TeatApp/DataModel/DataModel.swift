//
//  DataModel.swift
//  TeatApp
//
//  Created by 王冠之 on 2019/9/10.
//  Copyright © 2019 wangkuanchih. All rights reserved.
//

import Foundation

struct Room: Codable {
    var thumbnail: String
    var name: String
    var price: Int
}

struct Addition: Codable {
    var thumbnil: String
    var title: String
    var description: String
}

struct ContentDataModel: Codable {
    var plusData: [Addition]
    var roomList: [Room]
}

