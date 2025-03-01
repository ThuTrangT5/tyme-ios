//
//  LoadingState.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import SwiftUI

struct LoadingState: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var viewModel: BaseViewModel
    private let textStyle = AppStyles.labelStyle
    private var bgColor: Color  {
        Color.theme.background
    }
    
    var loadingView: some View {
        VStack {
            if (!viewModel.loadingMessage.isEmpty) {
                Text(viewModel.loadingMessage)
                    .modifier(textStyle)
                    .padding(.horizontal)
            }
            ProgressView()
                .tint(Color.theme.highlight)
        }
        .frame(height: 100)
        .frame(minWidth: 160)
        .background(bgColor.opacity(0.5))
        .foregroundColor(Color.primary)
        .cornerRadius(20)
        .opacity(viewModel.isLoading ? 1 : 0)
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(viewModel.isLoading)
                .blur(radius: viewModel.isLoading ? 3 : 0)
            
            if (viewModel.isLoading) {
                loadingView
            }
        }
    }
}

