//
//  FilteredList.swift
//  Project12
//
//  Created by Paul Hudson on 17/02/2020.
//  Copyright © 2020 Paul Hudson. All rights reserved.
//

import CoreData
import SwiftUI

enum PredicateType: String {
    case beginsWith = "BEGINSWITH"
    case lessThan = "<"
    case lessThanOrEqualTo = "<="
    case greaterThan = ">"
    case greaterThanOrEqualTo = ">="
    case equalTo = "="
    case notEqualTo = "!="
    case matches = "MATCHES"
    case like = "LIKE"
    case endsWith = "ENDSWITH"
    case In = "IN"
    case customSelector = "CUSTOMSELECTOR"
    case contains = "CONTAINS"
    case between = "BETWEEN"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content
    
    init(sortDescriptors: [NSSortDescriptor] = [],
         predicateType: PredicateType = .beginsWith,
         filterKey: String,
         filterValue: String,
         @ViewBuilder content: @escaping (T) -> Content) {
        let predicate = NSPredicate(format: "%K \(predicateType.rawValue) %@", filterKey, filterValue)
        fetchRequest = FetchRequest<T>(entity: T.entity(),
                                       sortDescriptors: sortDescriptors,
                                       predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
}

