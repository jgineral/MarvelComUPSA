//
//  ComicDetailRequest.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

struct ComicDetailRequest: BaseRequest {
    let comicId: Int
    
    init(comicId: Int) {
        self.comicId = comicId
    }

    var path: String { return "/v1/public/comics/\(comicId)" }
    
    var httpMethod: HTTPMethod { return .get }
}
