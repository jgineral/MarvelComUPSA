//
//  ComicListRemoteDataSource.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

protocol ComicListDataSourceProtocol {
    func getRecipesList(completion: @escaping (Result<[ComicModel], Error>) -> Void)
}

final class ComicListRemoteDataSource: ComicListDataSourceProtocol {
    let apiManager = AFWrapper()

    func getRecipesList(completion: @escaping (Result<[ComicModel], Error>) -> Void) {
        let request = ComicListRequest()
        apiManager.makeRequest(url: request.urlString,
                               queryParameters: nil,
                               headers: nil,
                               of: ComicListResponse.self) { result in
            switch result {
            case let .success(response):
                completion(.success(response.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
