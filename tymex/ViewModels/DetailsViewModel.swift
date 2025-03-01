//
//  DetailsViewModel.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import Foundation

class DetailsViewModel : BaseViewModel {
    @Published var userName: String?
    @Published var user: User?

    func getData(callback: ((Bool)->Void)? = nil) {
        if (userName ?? "").isEmpty {
            errorMessage = "User name is empty"
            callback?(false)
            return
        }
        
        isLoading = true
        let validName = userName ?? ""
        Services.shared.getUserDetails(userName: validName) { [weak self] user, error in
            self?.isLoading = false
            self?.user = user
            self?.errorMessage = error?.localizedDescription ?? ""
            let isSuccess = error == nil
            callback?(isSuccess)
            
        }
    }
}
