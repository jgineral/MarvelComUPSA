//
//  ComicListViewModel.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

final class ComicListViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var title: String = "Comics"
    @Published var list: [ComicUIModel] = []
    @Published var error: String?

    private var selectedOption: SelectionOption = .standard
    var pickerOptions = SelectionOption.allCases.map { $0.description }

    private let getComicListUseCase: GetComicListUseCaseProtocol
    private let getFavoritesComicListUseCase: GetFavoritesComicListUseCaseProtocol

    init(getComicListUseCase: GetComicListUseCaseProtocol,
         getFavoritesComicListUseCase: GetFavoritesComicListUseCaseProtocol) {
        self.getComicListUseCase = getComicListUseCase
        self.getFavoritesComicListUseCase = getFavoritesComicListUseCase
        self.title = selectedOption.description
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
    
    func loadFavoritesComics() {
        isLoading = true
        let params = GetFavoritesComicListParams { [weak self] result in
            switch result {
            case .success(let model):
                self?.list = model.map { $0.toUIModel() }
            case .failure(let error):
                self?.error = error.localizedDescription
            }
            self?.isLoading = false
        }
        getFavoritesComicListUseCase.run(params: params)
    }

    func selectOption(option: String) {
        selectedOption = SelectionOption(rawValue: option) ?? .standard
        switch selectedOption {
        case .favorites:
            loadFavoritesComics()
        case .standard:
            loadComics()
        }
    }
}

private extension ComicModel {
    func toUIModel() -> ComicUIModel {
        ComicUIModel(id: id, title: title, thumbnail: thumbnail)
    }
}

private extension ComicListViewModel {
    enum SelectionOption: CaseIterable {
        case standard
        case favorites

        init?(rawValue: String) {
            switch rawValue {
            case "Comics":
                self = .standard
            case "Comics favoritos":
                self = .favorites
            default:
                return nil
            }
        }

        var description: String {
            switch self {
            case .standard:
                return "Comics"
            case .favorites:
                return "Comics favoritos"
            }
        }

    }
}

