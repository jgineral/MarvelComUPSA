//
//  ComicListLocalDataSource.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import CoreData

final class ComicListLocalDataSource: ComicListDataSourceProtocol {
    private let viewContext = DataController.shared.managedContext

    func getComicList(completion: @escaping (Result<[ComicModel], Error>) -> Void) {
        let request = Comic.fetchRequest()
        request.sortDescriptors = []
        let fetchController = NSFetchedResultsController(fetchRequest: request,
                                                         managedObjectContext: viewContext,
                                                         sectionNameKeyPath: nil,
                                                         cacheName: nil)
        do {
            try fetchController.performFetch()
            let recipes = fetchController.fetchedObjects
            let model = recipes?.map { ComicModel(id: Int($0.id),
                                                  title: $0.title ?? "Title not found",
                                                  thumbnail: $0.imageUrl)} ?? []
            completion(.success(model))
        } catch {
            completion(.failure(error))
        }
    }
}
