//
//  ServiceHandler.swift
//  TeatApp
//
//  Created by 王冠之 on 2020/2/20.
//  Copyright © 2020 wangkuanchih. All rights reserved.
//

import UIKit

enum JSONError: String, Error {
    case unknownError = "Error: Unknowned"
    case noData = "Error: No Data!"
    case conversionFailed = "Error: conversion from JSON failed"
}

class ServiceHandler: NSObject {
    
    static let sharedHandeler = ServiceHandler()
    
    func fetchRoomData(using closure: @escaping(ContentDataModel?) -> Void) {
        let request = URLRequest(url: URL(string: "https://www.mocky.io/v2/5d78c8783000004c0031f70a")!)
        let requestTask = URLSession.shared.dataTask(with: request) {
            (data, respone, error) in
            do {
                guard error == nil else{
                    throw JSONError.unknownError
                }
                guard let data = data else{
                    throw JSONError.noData
                }
                let decoder = JSONDecoder()
                if let result = try? decoder.decode(ContentDataModel.self, from: data) {
                    closure(result)
                } else {
                    closure(nil)
                }
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }
        requestTask.resume()
    }
}
