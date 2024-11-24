//
//  Freight+CoreDataProperties.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 23/11/24.
//
//

import Foundation
import CoreData


extension Freight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Freight> {
        return NSFetchRequest<Freight>(entityName: "Freight")
    }

    @NSManaged public var cost: String?
    @NSManaged public var code: String?
    @NSManaged public var destiny: String?
    @NSManaged public var starLocation: String?
    @NSManaged public var info: String?
    @NSManaged public var freightToPackage: NSSet?
    
    public var packageArray: [Package] {
        let set = freightToPackage as? Set<Package> ?? []
    
        return Array(set)
    }

}

// MARK: Generated accessors for freightToPackage
extension Freight {

    @objc(addFreightToPackageObject:)
    @NSManaged public func addToFreightToPackage(_ value: Package)

    @objc(removeFreightToPackageObject:)
    @NSManaged public func removeFromFreightToPackage(_ value: Package)

    @objc(addFreightToPackage:)
    @NSManaged public func addToFreightToPackage(_ values: NSSet)

    @objc(removeFreightToPackage:)
    @NSManaged public func removeFromFreightToPackage(_ values: NSSet)

}

extension Freight : Identifiable {

}
