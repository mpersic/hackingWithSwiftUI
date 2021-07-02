//
//  AddView.swift
//  iExpense
//
//  Created by COBE on 20/04/2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var invalidNumber = false
    static let types = ["Business","Personal"]
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(Self.types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing:
                                    Button("save") {
                                        if let actualAmount = Int(self.amount)
                                        {
                                            let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                                            self.expenses.items.append(item)
                                            self.presentationMode.wrappedValue.dismiss()
                                            self.invalidNumber = false
                                        }
                                        else {
                                            //Add some validation to the Save button in AddView. If you enter “fish” or another thing that can’t be converted to an integer, show an alert telling users what the problem is.
                                            self.invalidNumber = true
                                        }
                                    }
            )
        }
        .alert(isPresented: $invalidNumber){
            Alert(title: Text("Error"), message: Text("Invalid number"), dismissButton: .default(Text("Please enter a number")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
