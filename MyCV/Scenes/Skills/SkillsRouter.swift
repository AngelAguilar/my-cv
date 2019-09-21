//
//  SkillsRouter.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation
import UIKit

class SkillsRouter: SkillsWireframe {

    weak var viewController: UIViewController?
    
    func assembleModule() -> UIViewController {
        
        let view = SkillsViewController()
        let presenter = SkillsPresenter()
        let networkManager = NetworkManager()
        let interactor = SkillsInteractor()
        
        presenter.view = view
        
        view.presenter = presenter
        view.presenter?.view = view
        view.presenter?.interactor = interactor
        view.presenter?.interactor?.networkManager = networkManager
        view.presenter?.interactor?.output = presenter
        view.presenter?.router = self
        self.viewController = view
        return view
    }
    
}


