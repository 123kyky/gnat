//
//  Gnat.swift
//  Gnat
//
//  Created by Kyle Roberts on 4/19/16.
//  Copyright © 2016 floundertech. All rights reserved.
//

import CoreData

@objc enum FrequencyUnit: Int {
    case Minutes, Hours, Day, Undefined
}

@objc enum DayOfTheWeek: Int16 {
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}

@objc(Gnat)
class Gnat: NSManagedObject {
    @NSManaged var title: String
    @NSManaged var message: String
    @NSManaged var endTime: NSDate
    @NSManaged var frequency: Int
    @NSManaged var frequencyUnit: FrequencyUnit
    @NSManaged var startTime: NSDate
    @NSManaged var days: NSArray
}

func dayOfTheWeekLabel(day: DayOfTheWeek) -> String {
    switch day {
    case .Sunday:
        return "Sunday"
    case .Monday:
        return "Monday"
    case .Tuesday:
        return "Tuesday"
    case .Wednesday:
        return "Wednesday"
    case .Thursday:
        return "Thursday"
    case .Friday:
        return "Friday"
    case .Saturday:
        return "Saturday"
    }
}

func frequencyUnitLabel(frequencyUnit: FrequencyUnit) -> String {
    switch frequencyUnit {
    case .Minutes:
        return "Minute"
    case .Hours:
        return "Hour"
    case .Day:
        return "Day"
    case .Undefined:
        return ""
    }
}
