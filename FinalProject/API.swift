//
//  API.swift
//  FinalProject
//
//  Created by Ji Hwan Seung on 20/04/2017.
//  Copyright © 2017 Ji Hwan Seung. All rights reserved.
//

import UIKit
import Alamofire

struct WeatherData {
    
    var time: NSDate!
    var temperature: [String: Double]
    var summary: String!
    var apparentTemperature: Double!
    var precipIntensity: Double!
    var precipProbability: Double!
    
    func getTemperature(temperature: Double) -> [String: Double] {
        var temperatureList = [String: Double]()
        let celsiusTemperature = (temperature - 32) * (5 / 9)
        temperatureList["Fahrenheit"] = temperature
        temperatureList["Celsius"] = celsiusTemperature
        
        return temperatureList
    }
    
}

class WeatherAPI {
    
    let longtitude = "-76.5019"
    let latitude = "42.4440"
    let key = "749f38b78fcd0ac7578a181eb655a805"
    

    
    func getData(completion: ([WeatherData]) -> Void) {
        let darkSkyURL = "https://api.darksky.net/forecast/" + key + "/" + latitude + "," + longtitude
        
        Alamofire.request(darkSkyURL).responseJSON(completionHandler:  { response in
            print ("requesting JSON")
            if let unwrappedData = response.data {
                self.parseData(JSONData: unwrappedData)
            }
        }).resume()
    }
    
    func parseData(JSONData: Data) -> [WeatherData] {
        print ("parsing data")
        var hourlyWeatherData = [WeatherData]()
        do {
            let JSON = try JSONSerialization.jsonObject(with: JSONData, options: .allowFragments) as? [String: AnyObject]
            if let unwrappedJSON = JSON {
                hourlyWeatherData = getHourlyData(JSON: unwrappedJSON)
            }
        }
        catch {
            print(error)
        }
        return hourlyWeatherData
    }
    
    func getHourlyData(JSON: [String: AnyObject]) -> [WeatherData] {
        print ("organizing data")
        var hourlyWeatherData = [WeatherData]()
        
        if let hourlyJSON = JSON["hourly"] as? [String: AnyObject] {
            if let hourlyData = hourlyJSON["data"] as? [[String: AnyObject]] {
                
                for data in hourlyData {
                    
                    var singleHourWeatherData: WeatherData?
                    
                    if let time = data["time"] as? Double {
                        var unixTime = TimeInterval(time)
                        let humanTime = NSDate(timeIntervalSince1970: unixTime)
                        
                        singleHourWeatherData?.time = humanTime
                    }
                    
                    if let temperature = data["temperature"] as? Double {
                        singleHourWeatherData?.temperature = (singleHourWeatherData?.getTemperature(temperature: temperature))!
                    }
                    
                    if let summary = data["summary"] as? String {
                        singleHourWeatherData?.summary = summary
                    }
                    
                    if let apparentTemperature = data["apparentTemperature"] as? Double {
                        singleHourWeatherData?.apparentTemperature = apparentTemperature
                    }
                    
                    if let precipIntensity = data["precipIntensity"] as? Double {
                        singleHourWeatherData?.precipIntensity = precipIntensity
                    }
                    
                    if let precipProbability = data["precipProbability"] as? Double {
                        singleHourWeatherData?.precipProbability = precipProbability
                    }
                    
                    if let unwrappedWeatherData = singleHourWeatherData {
                        hourlyWeatherData.append(unwrappedWeatherData)
                    }
                }
            }
        }
        
        return hourlyWeatherData
    }
    
}
