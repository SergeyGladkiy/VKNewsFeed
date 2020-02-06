//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Serg on 07/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

final class NetworkService {
    
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
    
    private func getUrl(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
    
    private func getUrlForLongPollServer(from server: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.path = server
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
}

extension NetworkService: Networking {
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        var allparams = params
        allparams["access_token"] = token
        allparams["v"] = API.version
        let url = self.getUrl(from: path, params: allparams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    func requestLongPollServer(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        let url = self.getUrlForLongPollServer(from: path, params: params)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
}
