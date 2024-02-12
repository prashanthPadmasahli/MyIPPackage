//
//  ContentViewModel.swift
//  FindMyIP
//
//  Created by mac on 10/02/24.
//

import Foundation

struct IPDetail: Decodable {
    let ip: String
    let city: String
    let region: String
}

class ContentViewModel: ObservableObject {
    var networkService: NetworkService
    @Published var ipDetail: IPDetail?
    @Published var isLoading = false
    @Published var showError = false
    @Published var errorMessage = "" {
        didSet {
            showError = true
        }
    }
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    @MainActor
    func getIpAddress() async {
        self.isLoading = true
        defer { self.isLoading = false }
        do {
            let response = try await networkService.sendRequest(urlStr: "https://ipapi.co/json") as IPDetail
            self.ipDetail = response
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
}
