//
//  HomeViewModel.swift
//  TestTask
//
//  Created by Mariam on 28.08.23.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    let networkManager = NetworkManager()
    var updateCollection: ()->() = {}
    var items: [HomeModel] = []
    var favoriteItems: [HomeModel] = []
    var url: String = ""
    var currentPage = 1
    var pageSize = 20
    var isFetchingData = false
    
    // MARK: - Functions
    func getImages() {
        if isFetchingData {
            return
        }
        isFetchingData = true
        networkManager.makeRequest(url: "https://jsonplaceholder.typicode.com/photos?_page=\(currentPage)&_limit=\(pageSize)") { result in
            switch result {
            case .success(let success):
                do {
                    let decoder = JSONDecoder()
                    let decodedModel = try decoder.decode(HomeItemsModel.self, from: success)
                    self.items += decodedModel
                    self.isFetchingData = false
                    self.updateCollection()
                } catch {
                    print("Error decoding model: \(error)")
                }
                
            case .failure(let failure):
                fatalError(failure.errorMessage)
            }
        }
    }
    
    func addToFavs(id: Int) {
        if let favorites = items.first(where: {$0.id == id}) {
            favoriteItems.append(favorites)
            NotificationCenter.default.post(name: Notification.Name("itemData"), object: nil, userInfo: ["items": favoriteItems])
        }
    }
    
    func removeFromFavs(id: Int) {
        favoriteItems.removeAll(where: {$0.id == id})
        NotificationCenter.default.post(name: Notification.Name("itemData"), object: nil, userInfo: ["items": favoriteItems])
    }
}
