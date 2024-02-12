//
//  ContentView.swift
//  FindMyIP
//
//  Created by mac on 10/02/24.
//

import SwiftUI

public struct IPAdressView: View {
    @StateObject var viewModel = ContentViewModel()
    
    public init () {}
    
    public var body: some View {
        VStack {
            if let model = viewModel.ipDetail {
                Text(model.ip)
                Text(model.city)
                Text(model.region)
            }
        }
        .modifier(LoadingIndicator(isLoading: viewModel.isLoading))
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK") { }
        } message: {
            Text(viewModel.errorMessage)
        }
        .task {
            await viewModel.getIpAddress()
        }
    }
}

struct LoadingIndicator: ViewModifier {
    var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                ProgressView()
            }
        }
    }
}
