//
//  Date+CoreDataProperties.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 23/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//
//

import Foundation
import CoreData


extension Date {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Date> {
        return NSFetchRequest<Date>(entityName: "Date")
    }

    @NSManaged public var dateform: String?
    @NSManaged public var dateno: String?
    @NSManaged public var dateto: String?
    @NSManaged public var timeform: String?
    @NSManaged public var timeto: String?
    @NSManaged public var trdateid: Int32
    @NSManaged public var trno: String?

}
