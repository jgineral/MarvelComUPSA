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

    var pickerSelection = ""
    var pickerOptions = SelectionOption.allCases.map { $0.description }

    private let getComicListUseCase: GetComicListUseCaseProtocol
    private let getFavoritesComicListUseCase: GetFavoritesComicListUseCaseProtocol
    private var selectedOption: SelectionOption = .standard
    private var apiList: [ComicModel]?

    init(getComicListUseCase: GetComicListUseCaseProtocol,
         getFavoritesComicListUseCase: GetFavoritesComicListUseCaseProtocol) {
        self.getComicListUseCase = getComicListUseCase
        self.getFavoritesComicListUseCase = getFavoritesComicListUseCase
        self.title = selectedOption.description
        self.pickerSelection = selectedOption.description
    }

    func loadData() {
        switch selectedOption {
        case .favorites:
            loadFavoritesComics()
        case .standard:
            loadComics()
        }
    }

    private func loadComics() {
        guard apiList == nil else {
            list = apiList?.map { $0.toUIModel() } ?? []
            return
        }
        isLoading = true
        let params = GetComicListParams { [weak self] result in
            switch result {
            case .success(let model):
                self?.apiList = model
                self?.list = model.map { $0.toUIModel() }
            case .failure(let error):
                self?.error = error.localizedDescription
            }
            self?.isLoading = false
        }
        getComicListUseCase.run(params: params)
    }
    
    private func loadFavoritesComics() {
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
        pickerSelection = option
        selectedOption = SelectionOption(rawValue: option) ?? .standard
        loadData()
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

