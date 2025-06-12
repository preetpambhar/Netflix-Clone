//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-24.
//

import Foundation
import UIKit
import CoreData


class DataPersistenceManager {
    
    enum DatabaseError: Error{
        case failedtoSaveData
        case failedToFetchData
        case failedToDeleteTheData
    }
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Video, completion: @escaping (Result<Void, Error>) -> Void){
         
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = VideoItem(context: context)
        
        item.orignal_title = model.snippet.title
        item.orignal_description = model.snippet.description
        item.videoID = model.id.videoId
        item.poster_url = model.snippet.thumbnails.high.url
        do{
           try  context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DatabaseError.failedtoSaveData ))
        }
    }
    
    func fetchingTitlesFromDataBase(completion: @escaping (Result<[VideoItem], Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<VideoItem>
        
        request = VideoItem.fetchRequest()
        
        do{
          let videos =  try context.fetch(request)
            completion(.success(videos))
        }catch{
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    func deleteTitleWith(model: VideoItem, completion: @escaping(Result<Void, Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DatabaseError.failedToDeleteTheData))
        }
    }
}
