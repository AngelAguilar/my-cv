//
//  MyProfilePresenter.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation

class MyProfilePresenter: MyProfilePresentation {

    var interactor: MyProfileUseCase?
    var router: MyProfileWireframe?
    weak var view: MyProfileView?
    
    func viewDidLoad() {
        interactor?.getProfileData()
    }
    func getProfileImageData(from url: String) {
        interactor?.getImage(from: url)
    }
    
    func didTapSkills() {
        router?.presentSkillsView()
    }
    
    func didTapExperience() {
        router?.presentExperienceView()
    }
    
}

extension MyProfilePresenter: MyProfileInteractorOutput {
    func getProfileImageSuccess(imageData: Data) {
        view?.loadProfileImageData(imageData)
    }
    
    func getProfileDataSuccess(profile: Profile) {
        view?.loadProfileData(profile)
    }
    
    func getProfileDataError(error: String) {
        view?.showError(error)
    }
    
}
