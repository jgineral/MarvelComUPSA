//
//  ComicDetailViewModel.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

final class ComicDetailViewModel: ObservableObject {
    @Published var detail: ComicDetailUIModel?
    @Published var error: String?
    @Published var isLoading: Bool = false
    @Published var buttonTitle = "Añadir favorito"
    @Published var buttonImage = "star"
    @Published var configuration = DetailUIConfig()
    
    struct DetailUIConfig {
        let dateSectionTitle = "Fechas destacadas"
        let creatorsSectionTitle = "Creadores"
        let creatorsName = "Nombre"
        let creatorsRole = "Rol"
    }


    private let comicId: Int
    private var comicModel: ComicDetailModel?
    private let getComicUseCase: GetComicDetailUseCaseProtocol
    private let saveFavoriteUseCase: SaveFavoriteComicUseCaseProtocol
    private let removeFavoriteUseCase: RemoveFavoriteComicUseCaseProtocol

    init(comicId: Int,
         getComicUseCase: GetComicDetailUseCaseProtocol,
         saveFavoriteUseCase: SaveFavoriteComicUseCaseProtocol,
         removeFavoriteUseCase: RemoveFavoriteComicUseCaseProtocol) {
        self.comicId = comicId
        self.getComicUseCase = getComicUseCase
        self.saveFavoriteUseCase = saveFavoriteUseCase
        self.removeFavoriteUseCase = removeFavoriteUseCase
    }
    
    func loadComic() {
        isLoading = true
        let params = GetComicDetailUseCaseParams(id: comicId) { [weak self] result in
            switch result {
            case .success(let model):
                self?.comicModel = model
                self?.detail = model.toViewModel()
                self?.updateFavoriteButton()
            case .failure(let error):
                self?.error = error.localizedDescription
            }
            self?.isLoading = false
        }
        getComicUseCase.run(params: params)
    }

    func updateFavorite() {
        guard let comicModel else {
            return
        }
        comicModel.isFavorite ? deleteFavorite() : saveFavorite()
    }

    private func saveFavorite() {
        guard let comicModel else {
            return
        }
        let model = ComicModel(id: comicModel.id,
                               title: comicModel.title,
                               thumbnail: comicModel.image)
        let params = SaveFavoriteComicUseCaseParams(model: model) { [weak self] result in
            switch result {
            case .success:
                self?.comicModel = ComicDetailModel(id: comicModel.id,
                                                    title: comicModel.title,
                                                    description: comicModel.description,
                                                    image: comicModel.image,
                                                    dates: comicModel.dates,
                                                    creators: comicModel.creators,
                                                    isFavorite: true)
                self?.updateFavoriteButton()
            case .failure:
                break
            }
        }
        saveFavoriteUseCase.run(params: params)
    }

    private func deleteFavorite() {
        guard let comicModel else {
            return
        }
        let params = RemoveFavoriteComicUseCaseParams(id: comicModel.id) { [weak self] result in
            switch result {
            case .success:
                self?.comicModel = ComicDetailModel(id: comicModel.id,
                                                    title: comicModel.title,
                                                    description: comicModel.description,
                                                    image: comicModel.image,
                                                    dates: comicModel.dates,
                                                    creators: comicModel.creators,
                                                    isFavorite: false)
                self?.updateFavoriteButton()
            case .failure:
                break
            }
        }
        removeFavoriteUseCase.run(params: params)
    }

    private func updateFavoriteButton() {
        guard let comicModel else {
            return
        }
        buttonTitle = comicModel.isFavorite ? "Borrar favorito" : "Añadir favorito"
        buttonImage = comicModel.isFavorite ? "star.fill" : "star"
    }
}

private extension ComicDetailModel {
    func toViewModel() -> ComicDetailUIModel {
        ComicDetailUIModel(id: id,
                           title: title,
                           description: description,
                           image: image,
                           creators: creators.map { $0.toViewModel() },
                           dates: dates.map { $0.toViewModel() },
                           isFavorite: isFavorite)
    }
}

private extension CreatorModel {
    func toViewModel() -> CreatorUIModel {
        CreatorUIModel(name: name, role: getRoleDescription(role: role), color: role.color)
    }

    func getRoleDescription(role: CreatorModel.Role) -> String {
        switch role {
        case .colorist:
            return "Colorista"
        case .editor:
            return "Editor"
        case .inker:
            return "Encargado de impresión"
        case .penciller:
            return "Dibujante"
        case .writter:
            return "Escritor"
        case .unknown:
            return " - "
        }
    }
}

private extension DateModel {
    func toViewModel() -> DateUIModel {
        DateUIModel(date: date.formatted(), type: getDateDescription(type: type))
    }

    func getDateDescription(type: DateModel.ComicDateType) -> String {
        switch type {
        case .digitalPurchase:
            return "Fecha de venta digital"
        case .onSale:
            return "Fecha de venta"
        case .unlimited:
            return ""
        }
    }
}
