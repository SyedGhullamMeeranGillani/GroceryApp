//
//  AddStoreView.swift
//  GroceryApp
//
//  Created by Syed Ghullam Meeran Gillani on 27/07/2022.
//

import SwiftUI


struct AddStoreView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var addStoreVM = AddStoreViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                Form {
                    Section{
                        TextField("Name", text: $addStoreVM.name)
                        TextField("Address", text: $addStoreVM.address)
                        HStack{
                            Spacer()
                            Button {
                                addStoreVM.save()
                                
                            } label: {
                                Text("Save")
                                    .foregroundColor(Color.blue)
                            }
                            .onChange(of: addStoreVM.saved) { value in
                                if value {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                            Spacer()
                            
                            
                            
                        }
                        Text(addStoreVM.message)
                    }
                    
                    
                }
                .navigationBarItems(leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                }))
                .navigationTitle("Add New Store")
                
            }
        }
    }
}

struct AddStoreView_Previews: PreviewProvider {
    static var previews: some View {
        AddStoreView()
    }
}
