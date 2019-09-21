//
//  ExperienceRouter.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/10/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation
import UIKit

class ExperienceRouter: ExperienceWireframe {
    
    weak var viewController: UIViewController?
    
    func assembleModule() -> UIViewController {
        
        let view = ExperienceViewController()
        let presenter = ExperiencePresenter()
        let networkManager = NetworkManager()
        let interactor = ExperienceInteractor()
        
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
