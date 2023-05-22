//
//  RemoveFavoriteUseCaseMock.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import Foundation

final class RemoveFavoriteComicUseCaseMock: RemoveFavoriteComicUseCaseProtocol {
    func run(params: RemoveFavoriteComicUseCaseParams) {
        return params.completion(.success(()))
    }
}
