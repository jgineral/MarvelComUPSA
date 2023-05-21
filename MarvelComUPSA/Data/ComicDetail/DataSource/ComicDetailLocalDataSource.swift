//
//  ComicDetailLocalDataSourcee.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import CoreData

protocol ComicDetailLocalDataSourceProtocol {
    func saveComic(comic: ComicModel, completion: @escaping (Result<Void, Error>) -> Void)
    func removeComic(id: Int, completion: @escaping (Result<Void, Error>) -> Void)
    func isFavorite(id: Int, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class ComicDetailLocalDataSource: ComicDetailLocalDataSourceProtocol {
    private let viewContext = DataController.shared.managedContext

    func saveComic(comic: ComicModel, completion: @escaping (Result<Void, Error>) -> Void) {
        let recipe = Comic(context: viewContext)
        recipe.id = Int64(comic.id)
        recipe.title = comic.title
        recipe.imageUrl = comic.thumbnail
        
        do {
            try viewContext.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    func removeComic(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<Comic>
        fetchRequest = Comic.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int64(id))
        do {
            if let object = try viewContext.fetch(fetchRequest).first {
                viewContext.delete(object)
                try viewContext.save()
                completion(.success(()))
            }
        } catch {
            completion(.failure(error))
        }
    }

    func isFavorite(id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<Comic>
        fetchRequest = Comic.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int64(id))
        do {
            let objects = try viewContext.fetch(fetchRequest)
            let isFavorite = !objects.isEmpty
            completion(.success(isFavorite))
        } catch {
            completion(.failure(error))
        }
    }
}
