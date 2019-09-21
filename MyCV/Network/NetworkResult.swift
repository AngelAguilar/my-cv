//
//  NetworkResult.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation

enum NetworkResult<Data, Error>  {
    case success(Data)
    case failure(Error)
}
