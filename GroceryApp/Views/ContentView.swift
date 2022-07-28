//
//  ContentView.swift
//  GroceryApp
//
//  Created by Syed Ghullam Meeran Gillani on 27/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented : Bool = false
    @ObservedObject private var storeListVM = StoreListViewModel()
    
    var body: some View {
        NavigationView{
        VStack{
            
            List(storeListVM.stores, id: \.storeId){store in
                
                NavigationLink {
                    StoreItemsListView(store: store)
                } label: {
                    StoreCell(store: store)

                }

                
               
            }.listStyle(PlainListStyle())
        }
        .sheet(isPresented: $isPresented,onDismiss: {
            storeListVM.getAll()
        },content: {
            AddStoreView()
        })
        
        .navigationBarItems(trailing:
        Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        })
        )
        .navigationBarTitle("Grocery App")
        
        .onAppear(){
            storeListVM.getAll()
        }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct StoreCell: View{
    let store : StoreViewModel
    var body: some View{
        VStack(alignment: .leading, spacing: 8.0){
            Text(store.name)
                .font(.headline)
            Text(store.address)
                .font(.body)
        }
    }
}
