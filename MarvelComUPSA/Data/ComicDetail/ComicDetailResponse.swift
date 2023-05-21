//
//  ComicDetailResponse.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import Foundation

struct ComicDetailDataResponse: Decodable {
    let data: ComicDetailResultResponse?

    func toDomain() throws -> ComicDetailModel {
        guard let data else {
            let error = DecodingError.Context(codingPath: [CodingKeys.data], debugDescription: "Missing data")
            throw DecodingError.valueNotFound(ComicDetailDataResponse.self, error)
        }
        return try data.toDomain()
    }
}

struct ComicDetailResultResponse: Decodable {
    let results: [ComicDetailResponse]?

    func toDomain() throws -> ComicDetailModel {
        guard let comic = results?.first else {
            let error = DecodingError.Context(codingPath: [CodingKeys.results], debugDescription: "Missing first result")
            throw DecodingError.valueNotFound(ComicDetailResultResponse.self, error)
        }
        return try comic.toDomain()
    }
}

struct ComicDetailResponse: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let images: [ImagesResponse]?
    let creators: ComicCreatorItemsResponse?
    let dates: [ComicDetailResponseDate]?

    func toDomain() throws -> ComicDetailModel {
        guard let id else {
            let error = DecodingError.Context(codingPath: [CodingKeys.id], debugDescription: "Missing id")
            throw DecodingError.valueNotFound(ComicDetailResponse.self, error)
        }
        return ComicDetailModel(id: id,
                                title: title ?? "Title not found",
                                description: description ?? "Description not found",
                                image: images?.first?.toDomain(),
                                dates: dates?.compactMap { $0.toDomain() } ?? [],
                                creators: creators?.toDomain() ?? [])
    }
}

struct ComicDetailResponseDate: Decodable {
    let type: String?
    let date: String?
    
    func toDomain() -> DateModel? {
        guard let type = DateModel.ComicDateType(rawValue: type ?? ""),
              let date = try? Date(date ?? "", strategy: .dateTime) else {
            return nil
        }
        return DateModel(type: type, date: date)
    }
}

struct ComicCreatorItemsResponse: Decodable {
    let items: [ComicCreatorResponse]

    func toDomain() -> [CreatorModel] {
        items.compactMap { $0.toDomain() }
    }
}

struct ComicCreatorResponse: Decodable {
    let name: String?
    let role: String?

    func toDomain() -> CreatorModel? {
        guard let name else {
            return nil
        }
        return CreatorModel(name: name,
                            role: CreatorModel.Role(value: role ?? ""))
    }

}
