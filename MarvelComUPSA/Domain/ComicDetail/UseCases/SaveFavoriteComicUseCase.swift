//
//  SaveFavoriteComicUseCase.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import Foundation

struct SaveFavoriteComicUseCaseParams {
    let model: ComicModel
    let completion: ((Result<Void, Error>) -> Void)
}

protocol SaveFavoriteComicUseCaseProtocol {
    func run(params: SaveFavoriteComicUseCaseParams)
}

final class SaveFavoriteComicUseCase: SaveFavoriteComicUseCaseProtocol {
    private let repository: ComicDetailRepositoryProtocol

    init(repository: ComicDetailRepositoryProtocol) {
        self.repository = repository
    }

    func run(params: SaveFavoriteComicUseCaseParams) {
        repository.saveFavoriteComic(comic: params.model, completion: params.completion)
    }
}

