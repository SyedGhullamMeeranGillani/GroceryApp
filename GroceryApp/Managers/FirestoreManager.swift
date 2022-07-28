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
    func getStoreById(storeId: String , completion: @escaping(Result<Store?,Error>)-> Void){
        let re = db.collection("stores").document(storeId)
        re.getDocument { snapshot, error in
            if let error = error{
                completion(.failure(error))
            }else{
                if let snapshot = snapshot {
                    var store : Store? = try? snapshot.data(as: Store.self)
                    if snapshot != nil{
                        store?.id = snapshot.documentID
                        completion(.success(store))
                    }
                }
            }
            
        }
    }
    func getAllStores(completion: @escaping (Result<[Store]? , Error>) -> Void){
        db.collection("stores").getDocuments { snapshot, error in
            
            if let error = error {
                completion(.failure(error))
            }else{
                if let snapshot = snapshot {
                    let stores: [Store]? = snapshot.documents.compactMap { doc in
                        var store = try? doc.data(as: Store.self)
                        if store != nil{
                            store!.id = doc.documentID
                        }
                        return store
                    }
                    completion(.success(stores))
                }
            }
        }
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
    
    func updateStore(storeId: String, values: [AnyHashable: Any], completion: @escaping (Result<Store?, Error>) -> Void){
        
        let ref = db.collection("stores").document(storeId)
        ref.updateData([
            "items": FieldValue.arrayUnion((values["items"] as? [String]) ?? [])
        ]
        ) { error in
            if let error = error{
                print(error.localizedDescription)
                completion(.failure(error))
            }else{
                
                self.getStoreById(storeId: storeId) { result in
                    switch result{
                    case .success(let store):
                        if let store = store {
                            
                            completion(.success(store))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                    
                }
                //refactor this code to the above code
                
                //                ref.getDocument { snapshot, error in
                //                    if let error = error {
                //                        completion(.failure(error))
                //
                //                    }else{
                //
                //                        if let snapshot = snapshot {
                //                            var store : Store? = try? snapshot.data(as: Store.self)
                //                            if store != nil{
                //                                store?.id = snapshot.documentID
                //                                completion(.success(store))
                //                            }
                //                        }
                //                    }
                //                }
            }
            
        }
    }
}
