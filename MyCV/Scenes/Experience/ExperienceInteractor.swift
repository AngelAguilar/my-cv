//
//  File.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/10/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation

class ExperienceInteractor: ExperienceUseCase {
    
    enum Routes: String {
        case experienceData = "https://gist.githubusercontent.com/AngelAguilar/c830f01a71289c30a93eceb6909a07a4/raw/79efaa1991f3de047e1278f3923a011383476859/experience.json"
    }
    
    var networkManager: NetworkManager?
    var output: ExperienceInteractorOutput?
    private let encodeUtils: EncodeUtils = EncodeUtils()
    
    func getExperience() {
        guard let url = URL(string: Routes.experienceData.rawValue) else {
            output?.getExperienceError(error: NetworkManager.NetworkError.invalidURL.rawValue)
            return
        }
        networkManager?.loadData(from: url) {
            [weak self]
            (result) in
            switch result {
            case .success(let data):
                self?.handleExperienceData(data)
            case .failure(_):
                self?.output?.getExperienceError(error: NetworkManager.NetworkError.serverError.rawValue)
            }
        }
    }
    
    func handleExperienceData(_ data: Data) {
        do {
            let jobs = try encodeUtils.get([Job].self, from: data)
            output?.getExperienceSuccess(experience: jobs)
        } catch(let error) {
            debugPrint(error)
            output?.getExperienceError(error: NetworkManager.NetworkError.decodingError.rawValue)
        }
    }
}
