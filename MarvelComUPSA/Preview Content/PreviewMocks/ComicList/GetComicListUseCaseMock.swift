//
//  GetComicListUseCaseMock.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import Foundation

final class GetComicListUseCaseMock: GetComicListUseCaseProtocol {
    func run(params: GetComicListParams) {
        guard let dummyURL = URL(string: "https://cdn.marvel.com/u/prod/marvel/i/mg/b/40/image_not_available/standard_incredible.jpg") else {
            let error = NSError(domain: "Invalid URL", code: 400)
            return params.completion(.failure(error))
        }
        let dummyModel = [ComicModel(id: 2, title: "Comic", thumbnail: dummyURL)]
        return params.completion(.success(dummyModel))
    }
}
