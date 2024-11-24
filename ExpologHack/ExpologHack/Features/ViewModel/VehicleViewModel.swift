//
//  VehicleViewModel.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import Foundation
import CoreData

class VehicleViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    @Published var vehicle: [Vehicle] = []
    
    func fetch() {
        let fetchRequest: NSFetchRequest<Vehicle> = Vehicle.fetchRequest()
        guard let fetchedContacts = try? viewContext.fetch(fetchRequest) else {
            return
        }
        vehicle = fetchedContacts
    }
    
    func createPackage(vehicle: [String]) -> [Vehicle] {
        var items: [Vehicle] = []
        
        vehicle.forEach { item in
            let newContact = Vehicle(context: viewContext)
            newContact.name = item
            newContact.id = UUID().description
            newContact.plate = "BRA2010"
            newContact.type = "Fiat Uno"
            newContact.loadCapacity = "100T"
            
            items.append(newContact)
            do {
                try viewContext.save()
            } catch let error as NSError {
                print("could not save \(error) \(error.userInfo)")
            }
        }
        
        return items
    }
}
