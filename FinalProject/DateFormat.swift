//
//  DateFormat.swift
//  FinalProject
//
//  Created by Ji Hwan Seung on 23/04/2017.
//  Copyright © 2017 Ji Hwan Seung. All rights reserved.
//

import UIKit

class DateFormat {
    
    func getHour(time: NSDate) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zz"
        let formattedTime = formatter.string(from: time as Date)
        let hourTime: Date = formatter.date(from: formattedTime)!
        formatter.dateFormat = "HH"
        let hourString = formatter.string(from: hourTime)
        
        if Int(hourString)! > 12 {
            let newHour = Int(hourString)! - 12
            return String(newHour) + "pm"
        } else if Int(hourString) == 0 {
            return "12am"
        } else if Int(hourString) == 12 {
            return "12pm"
        } else {
            let newHour = Int(hourString)!
            return String(newHour) + "am"
        }
    }
    
    func getCurrentTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        var minute = calendar.component(.minute, from: date)
        
        var minuteString = String(format: "%02d", minute)
        
        if hour > 12 {
            hour = hour - 12
            return "\(hour):\(minuteString) PM"
        } else if hour == 0 {
            return "12:\(minuteString) AM"
        } else if hour == 12 {
            return "12:\(minuteString) PM"
        } else {
            return "\(hour):\(minuteString) AM"
        }
        
    }
    
    func getCurrentDay() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM dd, yyyy"
        
        return formatter.string(from: Date())
    }
    
}
