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
}


struct CreatorModel {
    enum Role: String {
        case editor
        case collorist
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
            case "collorist":
                self = .collorist
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
        case foc = "focDate"
        case unlimited = "unlimitedDate"
        case digitalPurchase = "digitalPurchaseDate"
    }

    let type: ComicDateType
    let date: Date
}
