//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by COBE on 02/05/2021.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    let content : (T) -> Content
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self){ singer in
            self.content(singer)
        }
    }
    //Make it accept an array of NSSortDescriptor objects to get used in its fetch request
    init(filterKey:String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content){
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: descriptor, predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}
