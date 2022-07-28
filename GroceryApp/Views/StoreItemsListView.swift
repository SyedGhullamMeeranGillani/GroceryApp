//
//  StoreItemsListVIew.swift
//  GroceryApp
//
//  Created by Syed Ghullam Meeran Gillani on 28/07/2022.
//

import SwiftUI
//import Combine

struct StoreItemsListView: View {
    
    @State var store : StoreViewModel
    @ObservedObject private var storeItemListVM = StoreItemListViewModel()
    //    @State var cancellable: AnyCancellable?
    var body: some View {
        VStack{
            TextField("Enter item name ", text: $storeItemListVM.groceryItemName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button {
                storeItemListVM.addItemToStore(storeId: store.storeId)
            } label: {
                Text("save")
            }
            Text(storeItemListVM.groceryItemName)
            if let store = storeItemListVM.store{
                List(store.items, id: \.self){ item in
                    Text(item)
                }
            }
          
            Spacer()
        }.onAppear(){
            storeItemListVM.getStoreById(storeId: store.storeId)
            //            cancellable = storeItemListVM.$store.sink { value in
            //                if let  value = value {
            //                    store = value
            //                }
            //            }
        }
    }
}

struct StoreItemsListVIew_Previews: PreviewProvider {
    static var previews: some View {
        StoreItemsListView(store: StoreViewModel(store: Store(id: "123", name: "heb", address: "123 niaz beig", items: nil)))
    }
}
