//
//  AddStoreViewModel.swift
//  GroceryApp
//
//  Created by Syed Ghullam Meeran Gillani on 27/07/2022.
//

import Foundation

class AddStoreViewModel: ObservableObject{
    @Published var saved: Bool = false
    @Published var message : String = ""
    private var firestoreManager: FirestoreManager
    
    var name : String = ""
    var address: String = ""
    init(){
        firestoreManager = FirestoreManager()
    }
    
    func save(){
        let store = Store(name: name, address: address)
        
        firestoreManager.save(store: store) { result in
            switch result {
            case .success(let store):
                DispatchQueue.main.async {
                    self.saved = store == nil ? false: true
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.message = Constants.Messages.storeSavedFailure
                }
            }
        }
        
    }
}
