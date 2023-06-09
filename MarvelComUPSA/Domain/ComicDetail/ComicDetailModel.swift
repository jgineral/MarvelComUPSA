//
//  ComicDetailModel.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

struct ComicDetailModel {
    let id: Int
    let title: String
    let description: String
    let image: URL?
    let dates: [DateModel]
    let creators: [CreatorModel]
    let isFavorite: Bool
}


struct CreatorModel {
    enum Role: String {
        case editor
        case colorist
        case inker
        case writter
        case penciller
        case unknown
        
        init(value: String) {
            switch value {
            case "penciller", "penciler", "penciller (cover)":
                self = .penciller
            case "editor":
                self = .editor
            case "inker":
                self = .inker
            case "writer", "writter":
                self = .writter
            case "colorist":
                self = .colorist
            default:
                self = .unknown
            }
        }
    }

    let name: String
    let role: Role
}

struct DateModel {
    enum ComicDateType: String {
        case onSale = "onsaleDate"
        case unlimited = "unlimitedDate"
        case digitalPurchase = "digitalPurchaseDate"
    }

    let type: ComicDateType
    let date: Date
}
