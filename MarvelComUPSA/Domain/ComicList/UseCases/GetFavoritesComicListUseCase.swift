//
//  GetFavoritesComicListUseCase.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

struct GetFavoritesComicListParams {
    let completion: ((Result<[ComicModel], Error>) -> Void)
}

protocol GetFavoritesComicListUseCaseProtocol {
    func run(params: GetFavoritesComicListParams)
}

final class GetFavoritesComicListUseCase: GetFavoritesComicListUseCaseProtocol {
    private let repository: ComicListRepositoryProtocol
    
    init(repository: ComicListRepositoryProtocol) {
        self.repository = repository
    }
    
    func run(params: GetFavoritesComicListParams) {
        repository.getFavoritesComicList(completion: params.completion)
    }
}
