//
//  ComicListBuilder.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

enum Mode {
    case standard, favorites
}

final class ComicListBuilder {
    func build(mode: Mode) -> ComicListView {
        let dataSource = ComicListRemoteDataSource()
        let repository = ComicListRepository(dataSource: dataSource)
        let getComicUseCase = GetComicListUseCase(repository: repository)
        let viewModel = ComicListViewModel(mode: mode, getComicListUseCase: getComicUseCase)
        let view = ComicListView(viewModel: viewModel)
        return view
    }
}
