//
//  GetComicDetailUseCase.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

struct GetComicDetailUseCaseParams {
    let id: Int
    let completion: ((Result<ComicDetailModel, Error>) -> Void)
}

protocol GetComicDetailUseCaseProtocol {
    func run(params: GetComicDetailUseCaseParams)
}

final class GetComicDetailUseCase: GetComicDetailUseCaseProtocol {
    private let repository: ComicDetailRepositoryProtocol
    
    init(repository: ComicDetailRepositoryProtocol) {
        self.repository = repository
    }

    func run(params: GetComicDetailUseCaseParams) {
        repository.getComicDetail(id: params.id, completion: params.completion)
    }
}
