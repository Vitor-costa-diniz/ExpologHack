//
//  PackageViewModel.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 23/11/24.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class PackageViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
//    @Published var package: [Package] = []
    
//    func fetch() {
//        let fetchRequest: NSFetchRequest<Package> = Package.fetchRequest()
//        guard let fetchedContacts = try? viewContext.fetch(fetchRequest) else {
//            return
//        }
//        package = fetchedContacts
//    }
    
    func createPackage(packages: [String]) -> [Package] {
        var items: [Package] = []
        
        packages.forEach { item in
            let newContact = Package(context: viewContext)
            newContact.name = item
            newContact.amount = "100"
            newContact.destiny = "Teste"
            newContact.location = "Teste"
            newContact.code = "Teste"
            newContact.info = "Teste"
            
            items.append(newContact)
            do {
                try viewContext.save()
            } catch let error as NSError {
                print("could not save \(error) \(error.userInfo)")
            }
        }
        
        return items
    }
    
//    func deletePackage(package: Package) {
//        viewContext.delete(package)
//        do {
//            try viewContext.save()
//            fetch()
//        } catch let error as NSError {
//            print("Could not delete. \(error), \(error.userInfo)")
//        }
//    }
//    
//    
//    func updatePackage(package: Package, name: String) {
//        package.name = name
//        do {
//            try viewContext.save()
//            fetch()
//        } catch let error as NSError {
//            print("Could not update. \(error), \(error.userInfo)")
//        }
//    }
}

