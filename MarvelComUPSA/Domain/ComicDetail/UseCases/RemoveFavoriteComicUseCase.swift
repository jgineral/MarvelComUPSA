//
//  RemoveFavoriteComicUseCase.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import Foundation

struct RemoveFavoriteComicUseCaseParams {
    let id: Int
    let completion: ((Result<Void, Error>) -> Void)
}

protocol RemoveFavoriteComicUseCaseProtocol {
    func run(params: RemoveFavoriteComicUseCaseParams)
}

final class RemoveFavoriteComicUseCase: RemoveFavoriteComicUseCaseProtocol {
    private let repository: ComicDetailRepositoryProtocol

    init(repository: ComicDetailRepositoryProtocol) {
        self.repository = repository
    }

    func run(params: RemoveFavoriteComicUseCaseParams) {
        repository.removeFavoriteComic(id: params.id, completion: params.completion)
    }
}

