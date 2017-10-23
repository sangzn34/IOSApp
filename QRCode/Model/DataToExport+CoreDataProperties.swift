//
//  DataToExport+CoreDataProperties.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 23/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//
//

import Foundation
import CoreData


extension DataToExport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataToExport> {
        return NSFetchRequest<DataToExport>(entityName: "DataToExport")
    }

    @NSManaged public var afternoon_come: Int32
    @NSManaged public var id_emp: String?
    @NSManaged public var morning_come: Int32
    @NSManaged public var ot_come: Int32
    @NSManaged public var trdateid: Int32
    @NSManaged public var tremplist_id: Int32
    @NSManaged public var user_name: String?

}
