//
//  Gnat.swift
//  Gnat
//
//  Created by Kyle Roberts on 4/19/16.
//  Copyright © 2016 floundertech. All rights reserved.
//

import CoreData

@objc(Gnat)
class Gnat: NSManagedObject {
    @NSManaged var title: String
    @NSManaged var message: String
    @NSManaged var endTime: NSDate
    @NSManaged var frequency: Int
    @NSManaged var frequencyUnit: Int
    @NSManaged var startTime: NSDate
    @NSManaged var days: NSArray
}
