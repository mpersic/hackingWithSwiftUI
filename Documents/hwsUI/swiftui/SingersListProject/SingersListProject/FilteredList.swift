//
//  FilteredList.swift
//  SingersListProject
//
//  Created by COBE on 02/05/2021.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    enum Predicate:Int {
        case beginsWith = 1
        case endsWith
    }
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
    init(filterKey:String, filterValue: String, predicate: Predicate.RawValue, sortDescriptor: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content){
        if predicate == 1 {
            fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptor, predicate: NSPredicate(format: "%K BEGINSWITH %@",filterKey, filterValue))
            self.content = content
        }
        else {
            fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptor, predicate: NSPredicate(format: "%K ENDSWITH %@",filterKey, filterValue))
            self.content = content
        }
    }
}


