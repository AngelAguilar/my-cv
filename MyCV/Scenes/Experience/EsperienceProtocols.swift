//
//  EsperienceProtocols.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/10/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation
import UIKit

// ViewController
protocol ExperienceView: BaseView {
    func loadExperience(_ jobs: [Job])
}

//Presenter
protocol ExperiencePresentation: class {
    
    var view: ExperienceView? { get set }
    var interactor: ExperienceUseCase? { get set }
    var router: ExperienceWireframe? { get set }
    func viewDidAppear()
}

//Interactor
protocol ExperienceUseCase: class {
    
    var networkManager: NetworkManager? { get set }
    var output: ExperienceInteractorOutput? { get set }
    func getExperience()
}

//Interactor Output Callbacks
protocol ExperienceInteractorOutput: class {
    func getExperienceSuccess(experience: [Job])
    func getExperienceError(error: String)
}

//Wireframe routing
protocol ExperienceWireframe: BaseWireframe {
}
