//
//  EncodeUtils.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/7/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation

enum EncodeUtilsErrors: Error {
    case cantDecodeString
    case cantDecodeData
}

struct EncodeUtils {
    func getJSONString<T>(from: T) throws -> String where T: Encodable {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(from)
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw EncodeUtilsErrors.cantDecodeString
        }
        return jsonString
    }
    
    func get<T>(_ objectType: T.Type, from json: String) throws -> T where T: Decodable {
        let jsonDecoder = JSONDecoder()
        guard let data = json.data(using: .utf8) else {
            throw EncodeUtilsErrors.cantDecodeData
        }
        let object = try jsonDecoder.decode(T.self, from: data)
        return object
    }
    
    func get<T>(_ objectType: T.Type, from data: Data) throws -> T where T: Decodable {
        let jsonDecoder = JSONDecoder()
        let object = try jsonDecoder.decode(T.self, from: data)
        return object
    }
}
