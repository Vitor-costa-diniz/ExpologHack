//
//  FreightViewModel.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 23/11/24.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class FreightViewModel: ObservableObject {
    
    let viewContext = PersistenceController.shared.container.viewContext
    
    @Published var freight: [Freight] = []
    @Published var derparturePoint: String = ""
    @Published var stopPoints: [String] = []
    @Published var selectLoad: String = ""
    
    init() {
        self.fetch()
    }

    func fetch() {
        let fetchRequest: NSFetchRequest<Freight> = Freight.fetchRequest()
        guard let fetchedContacts = try? viewContext.fetch(fetchRequest) else {
            return
        }
        freight = fetchedContacts
    }

    func createfreight(model: String, packages: [Package]) {
        let newVehicle = Freight(context: viewContext)
        newVehicle.code = model
        newVehicle.addToFreightToPackage(NSSet(array: packages))
        do {
            try viewContext.save()
            fetch()
        } catch let error as NSError {
            print("could not save \(error) \(error.userInfo)")
        }
    }
    
    func deleteFreight(vehicle: Freight) {
        viewContext.delete(vehicle)
        do {
            try viewContext.save()
            fetch()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func deletePackageInFreight(package: Package, freight: Freight) {
        
        freight.removeFromFreightToPackage(package)
        
        do {
            try viewContext.save()
            fetch()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func updateFreight(vehicle: Freight, name: String, packages: [Package]) {
        vehicle.code = name
        vehicle.addToFreightToPackage(NSSet(array: packages))
        
        do {
            try viewContext.save()
            fetch()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
}
