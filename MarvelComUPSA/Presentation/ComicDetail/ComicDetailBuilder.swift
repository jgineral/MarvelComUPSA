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
        let repository = ComicDetailRepository(dataSource: dataSource)
        let getComicUseCase = GetComicDetailUseCase(repository: repository)
        let viewModel = ComicDetailViewModel(comicId: comicId, getComicUseCase: getComicUseCase)
        let view = ComicDetailView(viewModel: viewModel)
        return view
    }
}
