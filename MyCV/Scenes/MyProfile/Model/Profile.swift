//
//  Profile.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation

struct Profile: Codable {
    let name: String
    let summary: String
    let title: String
    let email: String
    let profile_image_url: String
}
