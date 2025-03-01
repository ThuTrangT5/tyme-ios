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
    
    var mainView: some View {
        List {
            ForEach(viewModel.users) { item in
                itemView(user: item)
                    .listRowSeparator(.hidden)
            }
            if (viewModel.isLoadAll == false) {
                
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
                
            }
        }
    }
}

#Preview {
    ListView()
}
