////
////  BaseCoordinator.swift
////  SB
////
////  Created by Alex Misko on 11.01.23.
////
//
//import Foundation
//
//enum Endpoint {
//    case none
//    case country
//    case appleAuth
//    case cart
//    case auth
//    case delete
//    case setPremium
//    case revokeAppleToken
//    case updatePushToken
//    case link
//
//    var rawValue: String {
//        switch self {
//        case .none:
//            return "/"
//        case .link:
//            return "/user/auth.json"
//        case .country:
//            return  "/api/getCountry"
//        case .appleAuth:
//            return "/api/appleAuth"
//        case .auth:
//            return "/api/auth"
//        case .delete:
//            return "/api/profile/delete"
//        case .setPremium:
//            return "/api/profile/premium"
//        case .revokeAppleToken:
//            return "/api/apauth.php"
//        case .updatePushToken:
//            return "/api/profile/push"
//        case .cart:
//            return "/"
//        }
//    }
//}
//
//
//
//
//
//enum HTTPMethod: String {
//    case POST
//    case PUT
//    case GET
//    case DELETE
//    case PATCH
//}
//
//protocol RequestBuildable {
//    var host: String { get }
//    var path: Endpoint { get }
//
//    var method: HTTPMethod { get }
//    var parameters: [String: Any] { get }
//    var headers: [String: String] { get }
//
//    func set(host: String) -> Self
//    func set(path: Endpoint) -> Self
//    func set(method: HTTPMethod) -> Self
//    func set<T: Encodable>(parameters: T) -> Self
//    func add(header name: String, value: String) -> Self
//    func set(headers: [String: String]) -> Self
//
//    func build() -> URLRequest?
//}
//
//class RequestBuilder: RequestBuildable {
//
////    private(set) var host: String = "https://run.mocky.io"
//    private(set) var host: String = "https://startingapp.website"
//
//    private(set) var path: Endpoint = .none
//
//    private(set) var method: HTTPMethod = .GET
//    private(set) var parameters: [String: Any] = [:]
//    private(set) var headers: [String: String] = ["Accept": "application/json",
//                                                  "Content-Type": "application/json"]
//    @discardableResult
//    func set(host: String) -> Self {
//        self.host = host
//        return self
//    }
//
//    @discardableResult
//    func set(path: Endpoint) -> Self {
//        self.path = path
//        return self
//    }
//
//    @discardableResult
//    func set(method: HTTPMethod) -> Self {
//        self.method    = method
//        return self
//    }
//
//    @discardableResult
//    func set<T: Encodable>(parameters: T) -> Self {
//        if let dictionary = parameters as? [String: Any] {
//            self.parameters = dictionary
//        } else {
//            let encoder = JSONEncoder()
//            encoder.keyEncodingStrategy = .convertToSnakeCase
//            guard let jsonData = try? encoder.encode(parameters) else { return self }
//            guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) else { return self }
//            if let dictionary = jsonObject as? [String: Any] {
//                self.parameters = dictionary
//            }
//        }
//        return self
//    }
//
//    @discardableResult
//    func add(header name: String, value: String) -> Self {
//        self.headers[name] = value
//        return self
//    }
//
//    @discardableResult
//    func set(headers: [String: String]) -> Self {
//        self.headers.merge(headers) { (_, last) -> String in
//            last
//        }
//        return self
//    }
//
//    func build() -> URLRequest? {
//        guard var urlComponents = URLComponents(string: host) else { return nil }
//        urlComponents.path = path.rawValue
//        print("path: \(urlComponents.url) ")
//        let isGetMethod = method == .GET
//        if  !parameters.isEmpty, isGetMethod {
//            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value as? String )}
//        }
//
//        guard let url = urlComponents.url else { return nil }
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = method.rawValue
//
//
//
//        if !parameters.isEmpty, !isGetMethod {
//            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
//            urlRequest.httpBody = jsonData
//            print("jsonData: \(parameters)")
//        }
//
//        headers.forEach { key, value in
//            urlRequest.addValue(value, forHTTPHeaderField: key)
//        }
//
//
//
//        parameters = [:]
//        headers = ["Accept": "application/json",
//                   "Content-Type": "application/json"]
//        return urlRequest
//    }
//
//}
