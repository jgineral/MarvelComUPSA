//
//  ComicListRemoteDataSource.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

final class ComicListRemoteDataSource: ComicListDataSourceProtocol {
    private let apiManager: AFWrapperProtocol

    init(apiManager: AFWrapperProtocol = AFWrapper()) {
        self.apiManager = apiManager
    }

    func getComicList(completion: @escaping (Result<[ComicModel], Error>) -> Void) {
        let request = ComicListRequest()
        apiManager.makeRequest(url: request.urlString,
                               method: request.httpMethod,
                               queryParameters: nil,
                               headers: nil,
                               of: ComicListDataResponse.self) { result in
            switch result {
            case let .success(response):
                completion(.success(response.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
