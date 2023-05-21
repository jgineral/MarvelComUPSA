//
//  ComicListViewModel.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

final class ComicListViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var title: String = "Comics"
    @Published var list: [ComicUIModel] = []
    @Published var error: String?

    private let getComicListUseCase: GetComicListUseCaseProtocol
    private let mode: Mode

    init(mode: Mode, getComicListUseCase: GetComicListUseCaseProtocol) {
        self.getComicListUseCase = getComicListUseCase
        self.mode = mode
        self.title = mode == .favorites ? "Comics favoritos" : "Comics"
    }
    
    func loadComics() {
        isLoading = true
        let params = GetComicListParams { [weak self] result in
            switch result {
            case .success(let model):
                self?.list = model.map { $0.toUIModel() }
            case .failure(let error):
                self?.error = error.localizedDescription
            }
            self?.isLoading = false
        }
        getComicListUseCase.run(params: params)
    }
}

private extension ComicModel {
    func toUIModel() -> ComicUIModel {
        ComicUIModel(id: id, title: title, thumbnail: thumbnail)
    }
}
