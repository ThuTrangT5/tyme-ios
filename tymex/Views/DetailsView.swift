//
//  DetailsView.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel = DetailsViewModel()
    
    private var _avatarSize: CGFloat = 100
    
    init(loginName: String? = nil) {
        viewModel.login = loginName
        viewModel.getData()
    }
    
    var avatar: some View {
        AsyncImage(url: URL(string: viewModel.user?.avatar ?? "")) { image in
            image.resizable()
        } placeholder: {
            Image(systemName: "person.crop.circle")
        }
        .frame(width: _avatarSize, height: _avatarSize)
        .clipShape(.rect(cornerRadius: _avatarSize/2))
    }
    
    var name: some View {
        HStack {
            VStack(spacing: 0) {
                Text(viewModel.userName)
                    .modifier(AppStyles.titleStyle)
                if (viewModel.user?.login ?? "").isEmpty == false {
                    Text("(" + (viewModel.user?.login ?? "") + ")")
                        .modifier(AppStyles.labelStyle)
                }
            }
            Spacer()
        }
    }
    
    var location: some View {
        HStack(alignment: .top) {
            Image(systemName: "mappin.and.ellipse.circle")
            Text(viewModel.user?.location ?? "")
        }
    }
    
    var topView: some View {
        HStack(alignment: .center, spacing: 10) {
            avatar
            VStack(alignment: .leading) {
                name
                if (viewModel.showLocation) {
                    Divider()
                    location
                }
            }
        }
        .padding(10)
        .background()
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 5)
    }
    
    var follow: some View {
        HStack(alignment: .center, spacing: 5) {
            
            Image(systemName: "person.2.fill")
                .frame( width: 40, height: 40)
                .background()
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: 1)
            Text(viewModel.follower)
                .modifier(AppStyles.labelStyle)
            
            Spacer()
            
            
            Text(viewModel.following)
                .modifier(AppStyles.labelStyle)
            Image(systemName: "person.badge.shield.checkmark.fill")
                .frame( width: 40, height: 40)
                .background()
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: 1)
            
        }
        .frame(height: 50)
    }
    
    var company: some View {
        HStack (alignment: .top) {
            Image(systemName: "suitcase.fill")
            Text(viewModel.user?.company ?? "")
                .modifier(AppStyles.labelStyle)
        }
    }
    
    var email: some View {
        HStack (alignment: .top) {
            Image(systemName: "envelope.fill")
            Text(viewModel.user?.email ?? "")
                .modifier(AppStyles.labelStyle)
        }
    }
    
    var blog: some View {
        VStack(alignment: .leading) {
            if (viewModel.user?.bio ?? "").isEmpty == false {
                Text(viewModel.user?.bio ?? "")
                    .modifier(AppStyles.labelStyle)
            }
            
            if (viewModel.isValidBlogUrl) {
                Text("Blog")
                    .modifier(AppStyles.labelStyle)
                
                Link(viewModel.user?.blog ?? "", destination: URL(string: viewModel.user?.blog ?? "")!)
            }
        }
    }
    
    var mainView: some View {
        VStack(alignment: .leading) {
            topView
            follow
            company
            email
            blog
            Spacer()
        }
        .padding(.horizontal, 10)
    }
    
    var body: some View {
        mainView
            .modifier(LoadingState(viewModel: viewModel))
            .padding()
    }
}

#Preview {
    DetailsView(loginName: "takeo")
}
