//
//  VehicleViewModel.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import Foundation
import SwiftUI
import CoreData

class VehicleViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    @Published var vehicles: [Vehicle] = []
    @Published var name: String?
    @Published var capacity: String?
    @Published var specs: String?
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
        newContact.id = UUID().description
        newContact.name = name ?? "Paulo"
        newContact.type = selectVehicleType.rawValue
        newContact.plate = vehiclePlate
        newContact.loadCapacity = capacity ?? "0T"
        newContact.height = height
        newContact.length = length
        newContact.width = width
        newContact.specs = specs
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("could not save \(error) \(error.userInfo)")
        }
        
        self.fetch()
        resetData()
    }
    
    func updateVehicle() {
        let vehicle = getVehicle()
        
        vehicle.name = name ?? "Paulo"
        vehicle.type = selectVehicleType.rawValue
        vehicle.plate = vehiclePlate
        vehicle.loadCapacity = capacity ?? "0T"
        vehicle.height = height
        vehicle.length = length
        vehicle.width = width
        vehicle.specs = specs
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("could not save \(error) \(error.userInfo)")
        }
        
        self.fetch()
        resetData()
    }
    
    func arePropertiesValid() -> Bool {
        let stringsToValidate = [vehiclePlate, height, length, width]
        return stringsToValidate.allSatisfy { !$0.isEmpty }
    }
    
    func getVehicleInfo(for component: VehicleComponentTitle) -> String {
        let vehicle = vehicles.first!
        
        switch component {
        case .vehicleType:
            return vehicle.type ?? "N/A"
        case .plate:
            return vehicle.plate ?? "N/A"
        case .loadCapacity:
            return vehicle.loadCapacity ?? "N/A"
        case .height:
            return vehicle.height ?? "N/A"
        case .length:
            return vehicle.length ?? "N/A"
        case .width:
            return vehicle.width ?? "N/A"
        }
    }
    
    func loadFirstVehicle() {
        guard let firstVehicle = vehicles.first else { return }
        self.name = firstVehicle.name
        self.capacity = firstVehicle.loadCapacity
        self.specs = firstVehicle.specs
        self.selectVehicleType = firstVehicle.type == "Carro" ? .car : .truck
        self.vehiclePlate = firstVehicle.plate ?? ""
        self.height = firstVehicle.height ?? ""
        self.length = firstVehicle.length ?? ""
        self.width = firstVehicle.width ?? ""
    }
    
    func resignFirstResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension VehicleViewModel {
    private func resetData() {
        selectVehicleType = .truck
        vehiclePlate = ""
        height = ""
        length = ""
        width = ""
        name = nil
        capacity = nil
        specs = nil
    }
    
    private func getVehicle() -> Vehicle {
        let fetchRequest: NSFetchRequest<Vehicle> = Vehicle.fetchRequest()
        guard let fetchedContacts = try? viewContext.fetch(fetchRequest) else {
            return .init()
        }
        
        return fetchedContacts.first!
    }
}
