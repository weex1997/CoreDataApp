//
//  Photos+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Wedad Almehmadi on 26/12/2022.
//
//

import Foundation
import CoreData


extension Photos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photos> {
        return NSFetchRequest<Photos>(entityName: "Photos")
    }

    @NSManaged public var selectedImageData: Date!

}

extension Photos : Identifiable {

}
