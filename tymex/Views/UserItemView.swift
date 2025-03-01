//
//  UserItemView.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import SwiftUI

struct UserItemView: View {
    var user: User?
    
    init(user: User? = nil) {
        self.user = user
    }
    
    private var _avatarSize: CGFloat = 80
    private var _hasLandingPage: Bool {
        user?.landingPage != nil && user?.landingPage?.isEmpty == false
    }
    
    private var _userName: String {
        (user?.name ?? user?.login) ?? ""
    }
    
    var avatar: some View {
        AsyncImage(url: URL(string: user?.avatar ?? "")) { image in
            image.resizable()
        } placeholder: {
            Image(systemName: "person.crop.circle")
        }
        .frame(width: _avatarSize, height: _avatarSize)
        .clipShape(.rect(cornerRadius: _avatarSize/2))
    }
    
    var name: some View {
        HStack {
            Text(_userName)
                .modifier(AppStyles.labelStyle)
            
            Spacer()
        }
    }
    
    var landingPage: some View {
        HStack(alignment: .top) {
            Image(systemName: "globe")
            Text(user?.landingPage ?? "")
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            avatar
            VStack(alignment: .leading) {
                name
                
                if (_hasLandingPage) {
                    Divider()
                    landingPage
                }
            }
        }
        .padding(10)
        .background()
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 5)
    }
}

#Preview {
    UserItemView(user: samleUser)
}

let samleUser = User(json: [
    "login": "mojombo",
        "id": 1,
        "node_id": "MDQ6VXNlcjE=",
        "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/mojombo",
        "html_url": "https://github.com/mojombo",
        "followers_url": "https://api.github.com/users/mojombo/followers",
        "following_url": "https://api.github.com/users/mojombo/following{/other_user}",
        "gists_url": "https://api.github.com/users/mojombo/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/mojombo/subscriptions",
        "organizations_url": "https://api.github.com/users/mojombo/orgs",
        "repos_url": "https://api.github.com/users/mojombo/repos",
        "events_url": "https://api.github.com/users/mojombo/events{/privacy}",
        "received_events_url": "https://api.github.com/users/mojombo/received_events",
        "type": "User",
        "user_view_type": "public",
        "site_admin": false
])
