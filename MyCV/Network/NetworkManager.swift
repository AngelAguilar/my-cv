//
//  NetworkManager.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation

class NetworkManager {
    
    enum NetworkError: String {
        case invalidURL = "Invalid url"
        case serverError = "Server error"
        case decodingError = "Error getting the data"
    }
    
    enum HTTPMethod : String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
    }
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }
    
    func loadData(from url: URL, completionHandler: @escaping (NetworkResult<Data, Error?>) -> Void) {
        session.loadData(from: url) {
            data, error in
                let result = data.map(NetworkResult.success) ?? .failure(error)
                completionHandler(result)
        }
    }
}
