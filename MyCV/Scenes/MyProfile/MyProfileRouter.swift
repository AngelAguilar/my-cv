//
//  MyProfileRouter.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation
import UIKit

class MyProfileRouter: MyProfileWireframe {

    weak var viewController: UIViewController?
    
    func assembleModule() -> UIViewController {
        
        let view = MyProfileViewController()
        let presenter = MyProfilePresenter()
        let networkManager = NetworkManager()
        let interactor = MyProfileInteractor()
        
        let navigation = UINavigationController(rootViewController:view)
        navigation.navigationBar.prefersLargeTitles = true
        presenter.view = view
        
        view.presenter = presenter
        view.presenter?.view = view
        view.presenter?.interactor = interactor
        view.presenter?.interactor?.networkManager = networkManager
        view.presenter?.interactor?.output = presenter
        view.presenter?.router = self
        self.viewController = view
        return navigation
        
    }
    
    func presentSkillsView() {
        let skillsRouter = SkillsRouter()
        let skillsViewController = skillsRouter.assembleModule()
        viewController?.navigationController?.pushViewController(skillsViewController, animated: true)
    }
    
    func presentExperienceView() {
        let experienceRouter = ExperienceRouter()
        let experienceViewController = experienceRouter.assembleModule()
        viewController?.navigationController?.pushViewController(experienceViewController, animated: true)
    }
    
    
}
