//
//  RootRouter.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import UIKit

class RootRouter {
    
    func presentMyProfileScene(window: UIWindow) {
        window.makeKeyAndVisible()
        let myProfileRouter: MyProfileRouter = MyProfileRouter()
        let myProfileViewController = myProfileRouter.assembleModule()
        window.rootViewController = myProfileViewController
    }
    
}
