//
//  NewsFeedModel.swift
//  GridDynamicsTask
//
//  Created by Apalya on 18/04/24.
//

import Foundation
struct Feeds: Codable {
    let articles: Articles?
}
struct Articles: Codable {
    let results: [NewsFeedModel]?
}
struct NewsFeedModel: Codable {
    let title: String?
    let body: String?
    let image: String?
}

protocol NewsFeedService {
    func getAllArticles(completion:@escaping((Result<Feeds, CustomError>) -> Void))
}
struct NewsFeedServicible: NewsFeedService, HttpClient {
    func getAllArticles(completion: @escaping ((Result<Feeds, CustomError>) -> Void)) {
        sendRequest(endPoint: NewsFeedURLPoint.getArticles, responseModel: Feeds.self) { result in
            completion(result)
        }
    }
    
//    func getAllArticles(completion: @escaping ((Articles, CustomError) -> Void)) {
//        sendRequest(endPoint: NewsFeedURLPoint.getArticles, responseModel: Articles.self) { result in
//            
//        }
//    }
}
