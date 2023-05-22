//
//  ComicDetailBuilderMock.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import Foundation
final class ComicDetailBuilderMock {
    
    func build(comicId: Int) -> ComicDetailView {
        let getComicUseCase = GetComicDetailUseCaseMock()
        let saveFavoriteUseCase = SaveFavoriteComicUseCaseMock()
        let removeFavoriteUseCase = RemoveFavoriteComicUseCaseMock()
        let viewModel = ComicDetailViewModel(comicId: comicId,
                                             getComicUseCase: getComicUseCase,
                                             saveFavoriteUseCase: saveFavoriteUseCase,
                                             removeFavoriteUseCase: removeFavoriteUseCase)
        let view = ComicDetailView(viewModel: viewModel)
        return view
    }
}
