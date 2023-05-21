//
//  ComicDetailViewModel.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

final class ComicDetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var detail: ComicDetailUIModel?
    @Published var error: String?

    private var comicId: Int
    private var getComicUseCase: GetComicDetailUseCaseProtocol
    
    init(comicId: Int, getComicUseCase: GetComicDetailUseCaseProtocol) {
        self.comicId = comicId
        self.getComicUseCase = getComicUseCase
    }
    
    func loadComic() {
        isLoading = true
        let params = GetComicDetailUseCaseParams(id: comicId) { [weak self] result in
            switch result {
            case .success(let model):
                self?.detail = model.toViewModel()
            case .failure(let error):
                self?.error = error.localizedDescription
            }
            self?.isLoading = false
        }
        getComicUseCase.run(params: params)
    }
}

private extension ComicDetailModel {
    func toViewModel() -> ComicDetailUIModel {
        ComicDetailUIModel(id: id,
                           title: title,
                           description: description,
                           image: image,
                           creators: creators.map { $0.toViewModel() },
                           dates: dates.map { $0.toViewModel() })
        
    }
}

private extension CreatorModel {
    func toViewModel() -> CreatorUIModel {
        CreatorUIModel(name: name, role: role.rawValue, color: role.color)
    }
}

private extension DateModel {
    func toViewModel() -> DateUIModel {
        DateUIModel(date: date.formatted(), type: type.rawValue)
    }
}
