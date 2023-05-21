//
//  GetComicListUseCase.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

struct GetComicListParams {
    let completion: ((Result<[ComicModel], Error>) -> Void)
}

protocol GetComicListUseCaseProtocol {
    func run(params: GetComicListParams)
}

final class GetComicListUseCase: GetComicListUseCaseProtocol {
    private let repository: ComicListRepositoryProtocol
    
    init(repository: ComicListRepositoryProtocol) {
        self.repository = repository
    }
    
    func run(params: GetComicListParams) {
        repository.getComicList(completion: params.completion)
    }
}
