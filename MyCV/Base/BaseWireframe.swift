//
//  BaseWireframe.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation
import UIKit

protocol BaseWireframe: class {
    var viewController: UIViewController? { get set }
    func assembleModule() -> UIViewController
}
