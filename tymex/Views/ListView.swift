//
//  ListView.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel = ListViewModel()
    
    func itemView(user: User) -> some View {
        UserItemView(user: user)
    }
    
    var loadMoreItem: some View {
        HStack {
            Spacer()
            Button("Click here to Load more") {
                viewModel.getMoreData()
            }
            Spacer()
        }
        .padding()
    }
    
    var mainView: some View {
        List {
            ForEach(viewModel.users) { item in
                itemView(user: item)
                    .background(
                        NavigationLink("", destination: DetailsView(loginName: item.login))
                            .opacity(0)
                    )
                    .listRowSeparator(.hidden)
            }
            if (viewModel.isLoadAll == false) {
                loadMoreItem
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                mainView
                    .modifier(LoadingState(viewModel: viewModel))
                    .navigationTitle("Gitlab Users")
                    .refreshable {
                        viewModel.reloadData()
                    }
            }
        }
    }
}

#Preview {
    ListView()
}
