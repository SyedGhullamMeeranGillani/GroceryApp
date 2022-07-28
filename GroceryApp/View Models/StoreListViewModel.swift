//
//  StoreListViewModel.swift
//  GroceryApp
//
//  Created by Syed Ghullam Meeran Gillani on 27/07/2022.
//

import Foundation

class StoreListViewModel: ObservableObject {
    private var firestoreManager: FirestoreManager
    
    @Published var stores: [StoreViewModel] = []
    
    init(){
        firestoreManager = FirestoreManager()
    }
    
    func getAll(){
        firestoreManager.getAllStores { result in
            switch result {
            case .success(let stores):
                if let store = stores {
                    DispatchQueue.main.async {
                        self.stores = store.map(StoreViewModel.init)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
struct StoreViewModel {
    let store : Store
    
    var storeId: String{
        store.id ?? ""
    }
    var name: String{
        store.name
    }
    var address: String{
        store.address
    }
    var items: [String]{
        store.items ?? []
    }
}
