//
//  ComicDetailRepository.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

final class ComicDetailRepository: ComicDetailRepositoryProtocol {
    private let dataSource: ComicDetailDataSourceProtocol
    private let localDataSource: ComicDetailLocalDataSource

    init(dataSource: ComicDetailDataSourceProtocol, localDataSource: ComicDetailLocalDataSource) {
        self.dataSource = dataSource
        self.localDataSource = localDataSource
    }

    func getComicDetail(id: Int, completion: @escaping (Result<ComicDetailModel, Error>) -> Void) {
        dataSource.getComicDetail(id: id) { [weak self] result in
            switch result {
            case .success(let model):
                self?.isFavorite(id: id) { result in
                    var isFavorite = false
                    if case .success(let favorite) = result {
                        isFavorite = favorite
                    }
                    let comicDetail = ComicDetailModel(id: model.id,
                                                       title: model.title,
                                                       description: model.description,
                                                       image: model.image,
                                                       dates: model.dates,
                                                       creators: model.creators,
                                                       isFavorite: isFavorite)
                    completion(.success(comicDetail))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func saveFavoriteComic(comic: ComicModel, completion: @escaping (Result<Void, Error>) -> Void) {
        localDataSource.saveComic(comic: comic, completion: completion)
    }

    func removeFavoriteComic(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        localDataSource.removeComic(id: id, completion: completion)
    }

    private func isFavorite(id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        localDataSource.isFavorite(id: id, completion: completion)
    }
}
