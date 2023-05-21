//
//  ComicListBuilder.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

final class ComicListBuilder {
    func build() -> ComicListView {
        let localDataSource = ComicListLocalDataSource()
        let dataSource = ComicListRemoteDataSource()
        let repository = ComicListRepository(dataSource: dataSource, localDataSource: localDataSource)
        let getFavoritesComicListUseCase = GetFavoritesComicListUseCase(repository: repository)
        let getComicUseCase = GetComicListUseCase(repository: repository)
        let viewModel = ComicListViewModel(getComicListUseCase: getComicUseCase,
                                           getFavoritesComicListUseCase: getFavoritesComicListUseCase)
        let view = ComicListView(viewModel: viewModel)
        return view
    }
}
