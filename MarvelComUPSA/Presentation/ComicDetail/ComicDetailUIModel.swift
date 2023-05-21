//
//  ComicDetailUIModel.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import SwiftUI

struct ComicDetailUIModel: Identifiable {
    let id: Int
    let title: String
    let description: String
    let image: URL?
    let creators: [CreatorUIModel]
    let dates: [DateUIModel]
    let isFavorite: Bool
}

struct CreatorUIModel: Identifiable {
    let id: UUID = UUID()
    let name: String
    let role: String
    let color: Color
}

extension CreatorModel.Role {
    var color: Color {
        switch self {
        case .colorist:
            return .blue
        case .editor:
            return .pink
        case .writter:
            return .green
        case .inker:
            return .yellow
        case .unknown:
            return .red
        case .penciller:
            return .orange
        }
    }
}
struct DateUIModel: Identifiable {
    let id: UUID = UUID()
    let date: String
    let type: String
}
