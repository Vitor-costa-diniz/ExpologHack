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
    @Published var vehicles: [Vehicle] = []
    @Published var name: String?
    @Published var selectVehicleType: VehicleType = .truck
    @Published var vehiclePlate: String = ""
    @Published var height: String = ""
    @Published var length: String = ""
    @Published var width: String = ""
    
    init() {
        self.fetch()
    }
    
    func fetch() {
        let fetchRequest: NSFetchRequest<Vehicle> = Vehicle.fetchRequest()
        guard let fetchedContacts = try? viewContext.fetch(fetchRequest) else {
            return
        }
        vehicles = fetchedContacts
    }
    
    func createVehicle() {
        let newContact = Vehicle(context: viewContext)
        newContact.name = ""
        newContact.id = UUID().description
        newContact.plate = vehiclePlate
        newContact.type = "Fiat Uno"
        newContact.loadCapacity = "100T"
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("could not save \(error) \(error.userInfo)")
        }
        
        self.fetch()
        resetData()
    }
    
    private func resetData() {
        selectVehicleType = .truck
        vehiclePlate = ""
        height = ""
        length = ""
        width = ""
        name = ""
    }
}
