//
//  WeatherData.swift
//  FinalProject
//
//  Created by Ji Hwan Seung on 23/04/2017.
//  Copyright © 2017 Ji Hwan Seung. All rights reserved.
//

import UIKit

struct WeatherData {
    
    var time: NSDate?
    var temperature: [String: Double]?
    var summary: String?
    var apparentTemperature: Double?
    var precipIntensity: Double?
    var precipProbability: Double?
    
    init(time: NSDate?, temperature: [String: Double]?, summary: String?, apparentTemperature: Double?, precipIntensity: Double?, precipProbability: Double?) {
        
        self.time = time
        self.temperature = temperature
        self.summary = summary
        self.apparentTemperature = apparentTemperature
        
        self.precipIntensity = precipIntensity
        self.precipProbability = precipProbability
        
    }
    
    func getTemperature(temperature: Double) -> [String: Double] {
        var temperatureList = [String: Double]()
        let celsiusTemperature = (temperature - 32) * (5 / 9)
        temperatureList["Fahrenheit"] = temperature
        temperatureList["Celsius"] = celsiusTemperature
        
        return temperatureList
    }
    
}

