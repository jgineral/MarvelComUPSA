//
//  AFWrapper.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//
import Alamofire
import Foundation

protocol AFWrapperProtocol {
    func makeRequest<T:Decodable>(url: String,
                                  method: HTTPMethod,
                                  queryParameters: Parameters?,
                                  headers: HTTPHeaders?,
                                  of type: T.Type,
                                  completion: @escaping (Result<T, Error>) -> Void)
}

final class AFWrapper: AFWrapperProtocol {
    let session = Session.default
    
    enum ConfigKeys: String {
        case apiKey = "apikey"
        case hash
        case ts
    }
    
    private var headers: HTTPHeaders = [] {
        didSet {
            headers.add(HTTPHeader.contentType("application/json"))
        }
    }
    
    private var defaultParameters: Parameters = [:]
    
    func makeRequest<T:Decodable>(url: String,
                                  method: HTTPMethod = .get,
                                  queryParameters: Parameters?,
                                  headers: HTTPHeaders?,
                                  of type: T.Type = T.self,
                                  completion: @escaping (Result<T, Error>) -> Void) {
        if let headers {
            for header in headers {
                self.headers.add(header)
            }
        }
        if let defaultParameters = getConfigParams() {
            self.defaultParameters = defaultParameters
            if let queryParameters {
                for parameter in queryParameters {
                    self.defaultParameters.updateValue(parameter.value, forKey: parameter.key)
                }
            }
        }
        session.request(url, method: method.AFMethod, parameters: defaultParameters, headers: self.headers)
            .validate()
            .cURLDescription(calling: { print($0) })
            .responseDecodable(of: type) { response in
                switch response.result {
                case let .success(model):
                    completion(.success(model))
                    
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
    
    private func getConfigParams() -> Parameters? {
        var config: Parameters = [:]
                
        if let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                
                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                    guard let apiKey = dict[ConfigKeys.apiKey.rawValue],
                          let hash = dict[ConfigKeys.hash.rawValue],
                          let ts = dict[ConfigKeys.ts.rawValue] else {
                        return nil
                    }
                    config[ConfigKeys.apiKey.rawValue] = apiKey
                    config[ConfigKeys.hash.rawValue] = hash
                    config[ConfigKeys.ts.rawValue] = ts
                    return config
                }
            } catch {
                print(error)
            }
        }
        return nil
    }
}

extension HTTPMethod {
    var AFMethod: Alamofire.HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }
}
