//
//  ComicListRepositoryProtocol.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import Foundation

protocol ComicListRepositoryProtocol {
    func getComicList(completion: @escaping (Result<[ComicModel], Error>) -> Void)
}
