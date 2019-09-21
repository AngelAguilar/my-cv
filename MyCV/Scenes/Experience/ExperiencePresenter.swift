//
//  ExperiencePresenter.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/10/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation

class ExperiencePresenter: ExperiencePresentation {
    
    var interactor: ExperienceUseCase?
    var router: ExperienceWireframe?
    weak var view: ExperienceView?
    
    func viewDidAppear() {
        interactor?.getExperience()
    }
}

extension ExperiencePresenter: ExperienceInteractorOutput {
    
    func getExperienceSuccess(experience: [Job]) {
        view?.loadExperience(experience)
    }
    
    func getExperienceError(error: String) {
        view?.showError(error)
    }
    
}
