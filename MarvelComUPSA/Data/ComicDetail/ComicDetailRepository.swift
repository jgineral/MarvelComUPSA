//
//  ComicDetailRepository.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

final class ComicDetailRepository: ComicDetailRepositoryProtocol {
    private let dataSource: ComicDetailDataSourceProtocol

    init(dataSource: ComicDetailDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func getComicDetail(id: Int, completion: @escaping (Result<ComicDetailModel, Error>) -> Void) {
        dataSource.getComicDetail(id: id, completion: completion)
    }
}
