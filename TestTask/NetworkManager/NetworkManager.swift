//
//  NetworkManager.swift
//  TestTask
//
//  Created by Mariam on 28.08.23.
//

import Foundation

enum NetworkingError: Error {
    case serverError
    case responseError(_ errorMessage: String)
    
    var errorMessage: String {
        switch self {
        case .serverError:
            return "Something went wrong"
        case .responseError(let errMessage):
            return errMessage
        }
    }
}

class NetworkManager {
    
     func makeRequest(url: String, completion: @escaping((Result<Data, NetworkingError>) -> Void) ) {
        guard let url = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            completion(.success(data))
        }
        task.resume()
    }
    
}
