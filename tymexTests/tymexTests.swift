//
//  tymexTests.swift
//  tymexTests
//
//  Created by Thu Trang on 1/3/25.
//

import Testing
@testable import tymex

struct tymexTests {
    
    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test func testModel() async throws {
        let sample = User(json: [
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
        
        let expectedLogin = "mojombo"
        let expectedLandingPage = "https://github.com/mojombo"
        
        #expect(expectedLogin == sample.login)
        #expect(expectedLandingPage == sample.landingPage)
        
    }
    
    @Test func testListViewModel() async throws {
        // setup
        let vm = ListViewModel()
        let expectedNumRecords = vm._limitPerPage
        let expectedNumRecordsFailed = 0
        
        // action
        await withCheckedContinuation { continuation in
            vm.reloadData(onSuccess: { isSuccess in
                
                // assert
                if (isSuccess) {
                    #expect(expectedNumRecords == vm.users.count)
                } else {
                    #expect(expectedNumRecordsFailed == vm.users.count)
                }
                continuation.resume()
            })
        }
       
    }
    
    @Test func testDetailsVuewModel() async throws {
        // setup
        let login = "mojombo"
        let userName = "Tom Preston-Werner"
        let vm = DetailsViewModel()
        vm.login = login
        
        // action
        await withCheckedContinuation { continuation in
            vm.getData(callback: { success in
                
                // assert
                #expect(login == vm.user?.login)
                #expect(userName == vm.user?.name)
                continuation.resume()
            })
        }
    }
}
