//
//  ComicDetailBuilder.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

final class ComicDetailBuilder {
    func build(comicId: Int) -> ComicDetailView {
        let dataSource = ComicDetailRemoteDataSource()
        let localDataSource = ComicDetailLocalDataSource()
        let repository = ComicDetailRepository(dataSource: dataSource, localDataSource: localDataSource)
        let getComicUseCase = GetComicDetailUseCase(repository: repository)
        let saveFavoriteUseCase = SaveFavoriteComicUseCase(repository: repository)
        let removeFavoriteUseCase = RemoveFavoriteComicUseCase(repository: repository)
        let viewModel = ComicDetailViewModel(comicId: comicId,
                                             getComicUseCase: getComicUseCase,
                                             saveFavoriteUseCase: saveFavoriteUseCase,
                                             removeFavoriteUseCase: removeFavoriteUseCase)
        let view = ComicDetailView(viewModel: viewModel)
        return view
    }
}
