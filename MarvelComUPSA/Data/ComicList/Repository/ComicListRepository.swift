//
//  ComicListRepository.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

final class ComicListRepository: ComicListRepositoryProtocol {
    private let dataSource: ComicListDataSourceProtocol

    init(dataSource: ComicListDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func getComicList(completion: @escaping (Result<[ComicModel], Error>) -> Void) {
        dataSource.getComicList(completion: completion)
    }
}
