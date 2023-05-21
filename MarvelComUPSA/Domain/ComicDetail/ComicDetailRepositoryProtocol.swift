//
//  ComicDetailRepositoryProtocol.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

protocol ComicDetailRepositoryProtocol {
    func getComicDetail(id: Int, completion: @escaping (Result<ComicDetailModel, Error>) -> Void)
    func saveFavoriteComic(comic: ComicModel, completion: @escaping (Result<Void, Error>) -> Void)
    func removeFavoriteComic(id: Int, completion: @escaping (Result<Void, Error>) -> Void)
}
