//
//  ComicDetailDataSource.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

protocol ComicDetailDataSourceProtocol {
    func getComicDetail(id: Int, completion: @escaping (Result<ComicDetailModel, Error>) -> Void)
}

final class ComicDetailRemoteDataSource: ComicDetailDataSourceProtocol {
    private let apiManager: AFWrapperProtocol

    init(apiManager: AFWrapperProtocol = AFWrapper()) {
        self.apiManager = apiManager
    }

    func getComicDetail(id: Int, completion: @escaping (Result<ComicDetailModel, Error>) -> Void) {
        let request = ComicDetailRequest(comicId: id)
        apiManager.makeRequest(url: request.urlString,
                               method: request.httpMethod,
                               queryParameters: nil,
                               headers: nil,
                               of: ComicDetailDataResponse.self) { result in
            switch result {
            case let .success(response):
                do {
                    let model = try response.toDomain()
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
