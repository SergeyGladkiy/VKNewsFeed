//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Serg on 07/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation


protocol DataFetcher {
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void)
    func getConversations(response: @escaping (MessagesResponse?) -> Void)
    func getLongPollServer(response: @escaping (ConnectionDataLongPollServer?) -> Void)
    func getTinder(response: @escaping (TinderResponseWrapped?) -> Void)
//    func getLongPollConnection(server: String, key: String, timestamp: Int, response: @escaping (FeedResponse?) -> Void) -> Void
}

class NetworkDataFetcher {
    
    private let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
    
}

extension NetworkDataFetcher: DataFetcher {
    
    //MARK: Newsfeed
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void) {
        
        var params = ["filters": "post, photo"]
        params["start_from"] = nextBatchFrom
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            guard let data = data else { return }
            
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    //MARK: Messages
    func getConversations(response: @escaping (MessagesResponse?) -> Void) {
        var params = ["offset": "0"]
        params["count"] = "20"
        params["filter"] = "all"
        networking.request(path: API.messages, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            guard let data = data else { return }
            print(data)
            let decoded = self.decodeJSON(type: MessagesResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    func createChat(response: @escaping (Chat?)-> Void) {
        var params = ["user_ids": "96053114"]
        params["title"] = "BeetLab"
        networking.request(path: API.createChat, params: params) { (data, error) in
            print("data \(String(describing: data))")
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            guard let data = data else { return }
            
            let decoded = self.decodeJSON(type: Chat.self, from: data)
            print("decoded \(String(describing: decoded?.chatId))")
            response(decoded)
        }
    }
    
    //MARK: LongPoll
    func getLongPollServer(response: @escaping (ConnectionDataLongPollServer?) -> Void) {
        let params: [String: String] = [
            "need_pts": "1",
            "lp_version": "3"]
        networking.request(path: API.getLongPoll, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            guard let data = data else { return }
            
            let decoded = self.decodeJSON(type: ConnectionDataLongPollWrapped.self, from: data)
            response(decoded?.response)
        }
        
    }
    
    func getLongPollConnection(server: String, key: String, timestamp: Int, response: @escaping (LongPollServerResponse?) -> Void) {
        let params: [String: String] = [
            "act": "a_check",
            "key": key,
            "ts": "\(timestamp)",
            "wait": "25",
            "mode": "2",
            "version": "3"]
        networking.requestLongPollServer(path: server, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            guard let data = data else { return }
            
            let decoded = self.decodeJSON(type: LongPollServerResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    //MARK: TinderConnection
    func getTinder(response: @escaping (TinderResponseWrapped?) -> Void) {
        networking.requestTinder(path: APIforTinder.path) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            guard let data = data else { return }
            print("data - \(data)")
            let decoded = self.decodeJSON(type: TinderResponseWrapped.self, from: data)
            response(decoded)
        }
        
    }
}
