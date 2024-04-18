//
//  HTTPDetails.swift
//  GridDynamicsTask
//
//  Created by Apalya on 18/04/24.
//

import Foundation

enum HttpMethod : String {
    case get, post
}
enum Response<T> {
    case success(value: T)
    case failure(error: Error)
}
enum CustomError: Error {
    case decode
    case invalidURL
    case unauthorized
    case message(error: String)
}
protocol URLPoint {
    var scheme: String {get}
    var host: String {get}
    var path: String {get}
    var method: HttpMethod {get}
    var body: [AnyHashable: Any]? {get}
    var apiKey: String {get}
}
extension URLPoint {
    var scheme: String {
        "https"
    }
    var host: String {
        "eventregistry.org"
    }
    var apiKey: String {
        "d358f5c4-6d86-40a2-ac5f-cd31dba0e3f8"
    }
}
enum NewsFeedURLPoint: URLPoint {
    case getArticles
    
    var path: String {
        "/api/v1/article/getArticles"
    }
    var method: HttpMethod {
        .post
    }
    var body: [AnyHashable : Any]? {
        ["action": "getArticles", "keyword": "news", "apiKey": apiKey]
    }
}

protocol HttpClient {
    func sendRequest<T:Codable>(endPoint:URLPoint, responseModel: T.Type, completetion:@escaping((Result<T, CustomError>) -> Void))
}
extension HttpClient {
    func sendRequest<T:Codable>(endPoint:URLPoint, responseModel: T.Type, completetion:@escaping((Result<T, CustomError>) -> Void)) {
        var urlComponents = URLComponents()
        urlComponents.scheme = endPoint.scheme
        urlComponents.host = endPoint.host
        urlComponents.path = endPoint.path
        guard let url = urlComponents.url else { return completetion(.failure(.invalidURL)) }
        debugPrint(url)
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        if let body = endPoint.body, let data = try? JSONSerialization.data(withJSONObject: body) {
            request.httpBody = data
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                return completetion(.failure(.decode))
            }
            switch httpResponse.statusCode {
            case 200...299:
                if let _data = data, let model = try? JSONDecoder().decode(T.self, from: _data) {
                    debugPrint(String(decoding: _data, as: UTF8.self))
                    completetion(.success(model))
                }else {
                    completetion(.failure(.decode))
                }
            case 401:
                completetion(.failure(.unauthorized))
            default: completetion(.failure(.message(error: "Something Went Wrong")))
            }
        }.resume()
    }
}
