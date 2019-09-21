//
//  SkillsInteractor.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation

class SkillsInteractor: SkillsUseCase {
    
    enum Routes: String {
        case skillsData = "https://gist.githubusercontent.com/AngelAguilar/1ead360fb9ed673c1a6200f11f732499/raw/d51881e858aee31210c1e2a0450ca8e7a4b476c8/skills.json"
    }
    
    var networkManager: NetworkManager?
    var output: SkillsInteractorOutput?
    private let encodeUtils: EncodeUtils = EncodeUtils()
    
    func getSkills() {
        guard let url = URL(string: Routes.skillsData.rawValue) else {
            output?.getSkillsError(error: NetworkManager.NetworkError.invalidURL.rawValue)
            return
        }
        networkManager?.loadData(from: url) {
            [weak self]
            (result) in
            switch result {
            case .success(let data):
                self?.handleSkillsData(data)
            case .failure(_):
                self?.output?.getSkillsError(error: NetworkManager.NetworkError.serverError.rawValue)
            }
        }
    }
    
    func handleSkillsData(_ data: Data) {
        do {
            let skills = try encodeUtils.get([Skill].self, from: data)
            output?.getSkillsSuccess(skills: skills)
        } catch(_) {
            output?.getSkillsError(error: NetworkManager.NetworkError.decodingError.rawValue)
        }
    }
}
