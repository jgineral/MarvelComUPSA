//
//  AFWrapper.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation
import Alamofire

class AFWrapper {
    let session = Session.default
    
    private var headers: HTTPHeaders = [] {
        didSet {
            headers.add(HTTPHeader.contentType("application/json"))
        }
    }
    
    private var defaultParameters: Parameters = [
        "apikey" : UserDefaults.standard.string(forKey: UserDefaultsKeys.ApiKey.rawValue) ?? "",
        "hash" : UserDefaults.standard.string(forKey: UserDefaultsKeys.Hash.rawValue) ?? "",
        "ts": UserDefaults.standard.string(forKey: UserDefaultsKeys.Ts.rawValue) ?? "",
    ]
    
    
    func makeRequest<T:Decodable>(url: String,
                                  method: HTTPMethod = .get,
                                  queryParameters: Parameters?,
                                  headers: HTTPHeaders?,
                                  of type: T.Type = T.self, completion: @escaping (Result<T, NSError>) -> Void) {
        
        if let headers {
            for header in headers {
                self.headers.add(header)
            }
        }
        
        if let queryParameters {
            for parameter in queryParameters {
                defaultParameters.updateValue(parameter.value, forKey: parameter.key)
            }
        }
        
        session.request(url, method: method, parameters: defaultParameters, headers: self.headers)
            .validate()
            .cURLDescription(calling: { print($0) })
            .responseDecodable(of: type) { response in
                switch response.result {
                case let .success(model):
                    completion(.success(model))
                    
                case let .failure(errorAF):
                    let error = NSError(domain: errorAF.localizedDescription, code: errorAF.responseCode ?? 500)
                    completion(.failure(error))
                }
            }
    }
}
