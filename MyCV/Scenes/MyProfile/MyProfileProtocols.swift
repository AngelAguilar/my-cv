//
//  MyProfileProtocols.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation
import UIKit

// ViewController
protocol MyProfileView: BaseView {
    func loadProfileData(_ data: Profile)
    func loadProfileImageData(_ data: Data)
}

//Presenter
protocol MyProfilePresentation: class {
    
    var view: MyProfileView? { get set }
    var interactor: MyProfileUseCase? { get set }
    var router: MyProfileWireframe? { get set }

    func viewDidLoad()
    func getProfileImageData(from url: String)
    func didTapSkills()
    func didTapExperience()
}

//Interactor
protocol MyProfileUseCase: class {
    
    var networkManager: NetworkManager? { get set }
    var output: MyProfileInteractorOutput? { get set }
    func getProfileData()
    func getImage(from url: String)
}

//Interactor Output Callbacks
protocol MyProfileInteractorOutput: class {
    func getProfileDataSuccess(profile: Profile)
    func getProfileImageSuccess(imageData: Data)
    func getProfileDataError(error: String)
}

//Wireframe routing
protocol MyProfileWireframe: BaseWireframe {
    func presentSkillsView()
    func presentExperienceView()
}
