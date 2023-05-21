//
//  ImagesResponse.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import Foundation

struct ImagesResponse: Decodable {
    let path: String?
    let imageType: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageType = "extension"
    }

    func toDomain() -> URL? {
        guard let path, let imageType else {
            return nil
        }
        return URL(string: "\(path).\(imageType)")
    }

}
