//
//  ComicListResponse.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

struct ComicListDataResponse: Decodable {
    let data: ComicListResultResponse

    func toDomain() -> [ComicModel] {
        data.toDomain()
    }
}

struct ComicListResultResponse: Decodable {
    let results: [ComicResponse]

    func toDomain() -> [ComicModel] {
        results.map { $0.toDomain() }
    }
}

struct ComicResponse: Decodable {
    let id: Int
    let title: String?
    let thumbnail: ImagesResponse?
    
    func toDomain() -> ComicModel {
        ComicModel(id: id,
                   title: title ?? "Title not found",
                   thumbnail: thumbnail?.toDomain())
    }
}
