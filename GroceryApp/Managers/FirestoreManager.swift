//
//  FirestoreManager.swift
//  GroceryApp
//
//  Created by Syed Ghullam Meeran Gillani on 27/07/2022.
//

import Foundation

import Firebase
import FirebaseFirestoreSwift

class FirestoreManager{
    
    private var db: Firestore
    init(){
        db = Firestore.firestore()
    }
    
    
    
    func save(store: Store, completion: @escaping( Result<Store?, Error>) -> Void){
        do{
           let ref = try db.collection("stores").addDocument(from: store)
            ref.getDocument { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(.failure(error!))
                    return
                }
                let store = try? snapshot.data(as: Store.self)
                completion(.success(store))

            }
        }catch let error{
            completion(.failure(error))
        }
    }
}