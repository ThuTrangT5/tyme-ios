//
//  BaseViewModel.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import Foundation


class BaseViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var loadingMessage = ""
    @Published var errorMessage = ""
}
