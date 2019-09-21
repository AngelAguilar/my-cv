//
//  SkillsPresenter.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation

class SkillsPresenter: SkillsPresentation {
    
    var interactor: SkillsUseCase?
    var router: SkillsWireframe?
    weak var view: SkillsView?
    
    func viewDidAppear() {
        interactor?.getSkills()
    }
}

extension SkillsPresenter: SkillsInteractorOutput {
    
    func getSkillsSuccess(skills: [Skill]) {
        view?.loadSkills(skills)
    }
    
    func getSkillsError(error: String) {
        view?.showError(error)
    }
    
}
