//
//  ComicListRepository.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

final class ComicListRepository: ComicListRepositoryProtocol {
    private let dataSource: ComicListDataSourceProtocol
    private let localDataSource: ComicListDataSourceProtocol

    init(dataSource: ComicListDataSourceProtocol, localDataSource: ComicListDataSourceProtocol) {
        self.dataSource = dataSource
        self.localDataSource = localDataSource
    }

    func getComicList(completion: @escaping (Result<[ComicModel], Error>) -> Void) {
        dataSource.getComicList(completion: completion)
    }

    func getFavoritesComicList(completion: @escaping (Result<[ComicModel], Error>) -> Void) {
        localDataSource.getComicList(completion: completion)
    }
}
