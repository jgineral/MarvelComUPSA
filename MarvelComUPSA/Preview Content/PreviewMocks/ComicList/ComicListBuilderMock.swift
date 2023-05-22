//
//  ComicListBuilderMock.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import Foundation

final class ComicListBuilderMock {
    func build() -> ComicListView {
        let getFavoritesComicListUseCase = GetFavoritesComicListUseCaseMock()
        let getComicUseCase = GetComicListUseCaseMock()
        let viewModel = ComicListViewModel(getComicListUseCase: getComicUseCase,
                                           getFavoritesComicListUseCase: getFavoritesComicListUseCase)
        let view = ComicListView(viewModel: viewModel)
        return view
    }
}
