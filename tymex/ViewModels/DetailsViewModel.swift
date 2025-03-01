//
//  DetailsViewModel.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import Foundation

class DetailsViewModel : BaseViewModel {
    @Published var login: String?
    @Published var user: User?

    func getData(callback: ((Bool)->Void)? = nil) {
        if (login ?? "").isEmpty {
            errorMessage = "User name is empty"
            callback?(false)
            return
        }
        
        isLoading = true
        let validName = login ?? ""
        Services.shared.getUserDetails(userName: validName) { [weak self] user, error in
            self?.isLoading = false
            self?.user = user
            self?.errorMessage = error?.localizedDescription ?? ""
            let isSuccess = error == nil
            callback?(isSuccess)
            
        }
    }
    
    var userName: String {
        (user?.name ?? user?.login) ?? ""
    }
    var showLocation: Bool {
        (user?.location ?? "").isEmpty == false
    }
    
    var follower: String {
        let num = user?.followers ?? 0
        if (num) < 100 {
            return "\(num)"
        }
        
        return "100+"
    }
    
    var following: String {
        let num = user?.following ?? 0
        if (num) < 100 {
            return "\(num)"
        }
        
        return "100+"
    }
    
    var isValidBlogUrl: Bool {
        (user?.blog ?? "").isEmpty == false 
    }
}
