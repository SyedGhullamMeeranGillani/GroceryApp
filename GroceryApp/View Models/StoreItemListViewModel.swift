//
//  StoreItemListViewModel.swift
//  GroceryApp
//
//  Created by Syed Ghullam Meeran Gillani on 27/07/2022.
//

import Foundation
class StoreItemListViewModel: ObservableObject{
    private var firestoreManager: FirestoreManager
    var groceryItemName : String = ""
    @Published var store : StoreViewModel?
    init(){
        firestoreManager = FirestoreManager()
    }
    func getStoreById(storeId: String){
        firestoreManager.getStoreById(storeId: storeId) { result in
            switch result{
            case .success(let store):
                if let store = store{
                    DispatchQueue.main.async {
                        self.store = StoreViewModel(store: store)

                    }
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    func addItemToStore(storeId: String ){
        firestoreManager.updateStore(storeId: storeId, values: ["items": [groceryItemName]]) { result in
            switch result{
            case .success(let storeModel):
                if let model = storeModel{
                    DispatchQueue.main.async {
                    self.store = StoreViewModel(store: model)
                    }
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
