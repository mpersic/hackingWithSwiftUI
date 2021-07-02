//
//  ContentView.swift
//  iExpense
//
//  Created by COBE on 19/04/2021.
//

import SwiftUI

struct User: Codable {
    var firstName: String
    var lastName: String
}
struct SecondView: View {
    @Environment (\.presentationMode) var presentationMode
    var name : String
    var body : some View {
        Text("Hello \(name)")
        Button("Dismiss"){
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ExpenseItem: Identifiable, Codable, Equatable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init () {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    var body: some View {
        NavigationView{
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        //Modify the expense amounts in ContentView to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style. What those styles are depend on you.
                        VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                        }
                        
                        Spacer()
                        Text("$\(item.amount)")
                        Button("Remove expense"){
                            guard let index = self.expenses.items.firstIndex(of: item) else { return }
                            self.removeItem(at: index)
                        }
                        .padding()
                        .background(Color.red)
                        .clipShape(Capsule())
                        //Add an Edit/Done button to ContentView so users can delete rows more easily.
                    }
                    .listRowBackground(item.amount < 10 ? Color.green : item.amount < 100 ? Color.yellow : Color.orange)
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showingAddExpense = true
                                    })  {
                                        Image(systemName: "plus")                }
            )
            .sheet(isPresented: $showingAddExpense){
                //show an AddView
                AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItem(at index: Int){
        expenses.items.remove(at: index)
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
