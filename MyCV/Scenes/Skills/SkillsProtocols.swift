//
//  SkillsProtocols.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation
import UIKit

// ViewController
protocol SkillsView: BaseView {
    func loadSkills(_ skills: [Skill])
}

//Presenter
protocol SkillsPresentation: class {
    
    var view: SkillsView? { get set }
    var interactor: SkillsUseCase? { get set }
    var router: SkillsWireframe? { get set }
    
    func viewDidAppear()
}

//Interactor
protocol SkillsUseCase: class {
    
    var networkManager: NetworkManager? { get set }
    var output: SkillsInteractorOutput? { get set }
    
    func getSkills()
}

//Interactor Output Callbacks
protocol SkillsInteractorOutput {
    func getSkillsSuccess(skills: [Skill])
    func getSkillsError(error: String)
}

//Wireframe routing
protocol SkillsWireframe: BaseWireframe {
}
