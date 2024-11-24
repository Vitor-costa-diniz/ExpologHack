//
//  Package+CoreDataProperties.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 23/11/24.
//
//

import Foundation
import CoreData


extension Package {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Package> {
        return NSFetchRequest<Package>(entityName: "Package")
    }

    @NSManaged public var amount: String?
    @NSManaged public var code: String?
    @NSManaged public var destiny: String?
    @NSManaged public var info: String?
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var packageToFreight: Freight?

}

extension Package : Identifiable {

}
