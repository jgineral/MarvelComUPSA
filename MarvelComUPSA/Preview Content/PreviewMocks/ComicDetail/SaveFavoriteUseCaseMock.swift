//
//  SaveFavoriteUseCaseMock.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import Foundation

final class SaveFavoriteComicUseCaseMock: SaveFavoriteComicUseCaseProtocol {
    func run(params: SaveFavoriteComicUseCaseParams) {
        return params.completion(.success(()))
    }
}
