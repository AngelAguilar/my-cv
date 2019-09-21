//
//  MyProfileInteractor.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//Copyright © 2019 Angel Aguilar. All rights reserved.
//

import Foundation
import UIKit

class MyProfileInteractor: MyProfileUseCase {
 
    enum Routes: String {
        case profileData = "https://gist.githubusercontent.com/AngelAguilar/634770ec708cca794ae281d7b57af7e6/raw/92f3b9a39a5a9c131a9b62d6bd9aab9260e0b6fa/profile.json"
    }
    
    var networkManager: NetworkManager?
    var output: MyProfileInteractorOutput?
    private let encodeUtils: EncodeUtils = EncodeUtils()
    
    func getProfileData() {
        guard let url = URL(string: Routes.profileData.rawValue) else {
            output?.getProfileDataError(error: NetworkManager.NetworkError.invalidURL.rawValue)
            return
        }
        networkManager?.loadData(from: url) {
            [weak self]
            (result) in
            switch result {
            case .success(let data):
                self?.handleProfileData(data)
            case .failure(_):
                self?.output?.getProfileDataError(error: NetworkManager.NetworkError.serverError.rawValue)
            }
        }
    }
    
    func getImage(from url: String) {
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        networkManager?.loadData(from: imageURL) {
            [weak self]
            (result) in
            switch result {
            case .success(let data):
                self?.output?.getProfileImageSuccess(imageData: data)
            case .failure(_):
                self?.output?.getProfileDataError(error: NetworkManager.NetworkError.serverError.rawValue)
            }
        }
    }
    
    func handleProfileData(_ data: Data) {
        do {
            let profile = try encodeUtils.get(Profile.self, from: data)
            output?.getProfileDataSuccess(profile: profile)
        } catch(_) {
            output?.getProfileDataError(error: NetworkManager.NetworkError.decodingError.rawValue)
        }
    }
}
