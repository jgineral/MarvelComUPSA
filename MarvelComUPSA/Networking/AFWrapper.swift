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

    private var headers: HTTPHeaders = [] {
        didSet {
            headers.add(HTTPHeader.contentType("application/json"))
        }
    }
    
    private var defaultParameters: Parameters = [
        "apikey" : "a5f94883eef2b754ff7d72db5cdbdc5c",
        "hash" : "f89445c504130a785a2daac4f37aeb16",
        "ts": "1684579022"
    ]
    
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

        if let queryParameters {
            for parameter in queryParameters {
                defaultParameters.updateValue(parameter.value, forKey: parameter.key)
            }
        }
        session.request(url, method: method.AFMethod, parameters: defaultParameters, headers: self.headers)
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
