//
//  Services.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import Foundation

import Alamofire
import SwiftyJSON

class Services: NSObject {
    
    static let shared = Services()
    
    private let baseURL = "https://api.github.com/"
    
    private override init() {
        super.init()
    }
    
    private func getHeader(accessToken: String? = nil) -> HTTPHeaders {
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json;charset=utf-8"
        ]
        
        return headers
    }
    
    private func sendRequest(method: HTTPMethod, urlString: String , parameters: Parameters? = nil, callback:((JSON, Error?)-> Void)?) {
        
        let url = self.baseURL + urlString
        let headers = self.getHeader()
        let params = parameters ?? [:]
        
        print("REQUEST: \(url)")
        
        AF.request(url, method: method, parameters: params, headers: headers)
            .responseJSON { (response) in
                
                switch response.result {
                case .success:
                    if let value = response.value {
                        let responseJson = JSON(value)
                        let success = responseJson["results"].bool ?? true
                        let errorMessage = responseJson["status_message"].stringValue
                        
                        if success == true {
                            callback?(responseJson, nil)
                        } else {
                            let error =  NSError(domain: NSURLErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                            callback?(JSON.null, error)
                        }
                    } else {
                        callback?(JSON.null, nil)
                    }
                    break
                    
                case let .failure(error):
                    callback?(JSON.null, error)
                    break
                }
            }
    }
    
    func getUsers(limit: Int, page: Int, callback: (([User], Error?)->Void)?) {
        //        since: 0...n, calculated by n*per_page
        //        per_page: 1...n
        let url = "users"
        let params: Parameters = [
            "per_page": limit,
            "since": (page - 1) * limit
        ]
        self.sendRequest(method: .get, urlString: url, parameters: params) { (response, error) in
            if let error = error {
                callback?([], error)
                
            } else {
                let users: [User] = User.getArray(json: response)
                callback?(users, nil)
            }
            
        }
    }
    
    func getUserDetails(userName: String, callback: ((User?, Error?)->Void)?) {
        let url = "users/\(userName)"
        
        self.sendRequest(method: .get, urlString: url) { (response, error) in
            if let error = error {
                callback?(nil, error)
                
            } else {
                let user: User = User(json: response)
                callback?(user, nil)
            }
            
        }
    }
}
