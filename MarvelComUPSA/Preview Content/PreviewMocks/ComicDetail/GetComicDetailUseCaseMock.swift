//
//  GetComicDetailUseCaseMock.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import Foundation

import Foundation

final class GetComicDetailUseCaseMock: GetComicDetailUseCaseProtocol {
    func run(params: GetComicDetailUseCaseParams) {
        guard let dummyURL = URL(string: "https://cdn.marvel.com/u/prod/marvel/i/mg/b/40/image_not_available/standard_incredible.jpg") else {
            let error = NSError(domain: "Invalid URL", code: 400)
            return params.completion(.failure(error))
        }
        let dummyModel = ComicDetailModel(id: 2,
                                          title: "Comic",
                                          description: "Dummy comic",
                                          image: dummyURL,
                                          dates: [DateModel(type: .digitalPurchase,
                                                            date: .now)],
                                          creators: [CreatorModel(name: "Creator",
                                                                  role: .editor)],
                                          isFavorite: false)
        return params.completion(.success(dummyModel))
    }
}
