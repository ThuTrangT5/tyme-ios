//
//  user.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import Foundation

import SwiftyJSON

class User: BaseModel, Codable, Identifiable  {
    var id: Int = 0
    var login: String
    var name: String?
    var avatar: String?
    var landingPage: String?
    
    var location: String?
    var followers: Int = 0
    var following: Int = 0
    var bio: String?
    var blog: String?
    var company: String?
    var email: String?
    
    required init(json: JSON) {
        
        id = json["id"].intValue
        login = json["login"].stringValue
        name = json["name"].string 
        avatar = json["avatar_url"].string
        landingPage = json["html_url"].string
        
        followers = json["followers"].intValue
        following = json["following"].intValue
        location = json["location"].string
        bio = json["bio"].string
        blog = json["blog"].string
        
        company = json["company"].string
        email = json["email"].string
        
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
