//
//  ListViewModel.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import Foundation

class ListViewModel : BaseViewModel {
    @Published var users: [User] = []
    @Published var currentPage = 1
    @Published var selectedUser: User?
    
    var _limitPerPage = 20
    @Published var isLoadAll: Bool = false
    
    override init() {
        super.init()
        reloadData()
    }
    
    func reloadData(onSuccess: ((Bool)->Void)? = nil) {
        users.removeAll()
        _getData(onSuccess: onSuccess)
    }
    
    func getMoreData(onSuccess: ((Bool)->Void)? = nil) {
        _getData(page: currentPage + 1, onSuccess: onSuccess)
    }
    
    private func _getData(page: Int = 1, onSuccess: ((Bool)->Void)? = nil) {
        isLoading = true
        Services.shared.getUsers(limit: _limitPerPage, page: page) { [weak self] (users, error) in
            self?.isLoading = false
            if (page == 1) {
                self?.users.removeAll()
            }
            
            self?.users.append(contentsOf: users)
            self?.currentPage = page
            self?.errorMessage = error?.localizedDescription ?? ""
            self?.isLoadAll = users.isEmpty
            let isSuccess = error == nil
            
            onSuccess?(isSuccess)
        }
    }
}
