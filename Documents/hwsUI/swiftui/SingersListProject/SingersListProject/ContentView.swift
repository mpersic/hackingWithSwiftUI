//
//  ContentView.swift
//  SingersListProject
//
//  Created by COBE on 02/05/2021.
//

import CoreData
import SwiftUI

struct ContentView: View {
    enum Predicate: Int {
        case beginsWith = 1
        case endsWith
    }
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    @State private var predicate: Predicate = Predicate.beginsWith
    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, predicate: predicate.rawValue, sortDescriptor: [
                            NSSortDescriptor(keyPath: \Singer.firstName, ascending: true),
                            NSSortDescriptor(keyPath: \Singer.lastName, ascending: true)]){
                (singer:Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            
            Button("Show A") {
                self.lastNameFilter = "A"
            }
            
            Button("Show S") {
                self.lastNameFilter = "S"
            }
            Button("Predicate"){
                if self.predicate == Predicate.beginsWith{
                    self.predicate = Predicate.endsWith
                }
                else {
                    self.predicate = Predicate.beginsWith
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
