//
//  Training+CoreDataProperties.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 23/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//
//

import Foundation
import CoreData


extension Training {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Training> {
        return NSFetchRequest<Training>(entityName: "Training")
    }

    @NSManaged public var approve_m: Int32
    @NSManaged public var approve_t: Int32
    @NSManaged public var ss: Int32
    @NSManaged public var trno: String?
    @NSManaged public var trtopic: String?

}
