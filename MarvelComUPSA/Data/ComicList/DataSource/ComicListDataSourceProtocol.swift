//
//  ComicListDataSourceProtocol.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import Foundation

protocol ComicListDataSourceProtocol {
    func getComicList(completion: @escaping (Result<[ComicModel], Error>) -> Void)
}
