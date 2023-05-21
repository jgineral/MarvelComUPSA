//
//  BaseRequest.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

enum HTTPMethod: String {
    case get, post, put, delete
}

protocol BaseRequest {
    var baseUrl: String { get }
    var path: String { get }
    var urlString: String { get }
    var httpMethod: HTTPMethod { get }
}

extension BaseRequest {
    var baseUrl: String { return NetworkConstants.baseUrl }
    var urlString: String { return baseUrl + path }
}
