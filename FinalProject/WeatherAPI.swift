//
//  API.swift
//  FinalProject
//
//  Created by Ji Hwan Seung on 20/04/2017.
//  Copyright © 2017 Ji Hwan Seung. All rights reserved.
//

import UIKit
import Alamofire


class WeatherAPI {
    
    let longtitude = "-76.5019"
    let latitude = "42.4440"
    let key = "749f38b78fcd0ac7578a181eb655a805"
    
    let requestMethod: HTTPMethod = .get
    let parameters = [String: Any]()
    let encoding: ParameterEncoding = URLEncoding.default
   
    
    func getData(completion: @escaping ([WeatherData], WeatherData) -> Void) {
        let darkSkyURL = "https://api.darksky.net/forecast/" + key + "/" + latitude + "," + longtitude
        
        request(darkSkyURL, method: requestMethod, parameters: parameters, encoding: encoding, headers: [String: String]()).validate().responseJSON(completionHandler: {response in
            if let unwrappedData = response.data {
                let hourlyjson = self.parseData(JSONData: unwrappedData)
                let currentjson = self.parseCurrentData(JSONData: unwrappedData)
                completion(hourlyjson, currentjson)
            }
        })
    }
    
    func parseData(JSONData: Data) -> [WeatherData] {

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
    
    func parseCurrentData(JSONData: Data) -> WeatherData {
        
        var currentWeatherData: WeatherData!
            do {
                let JSON = try JSONSerialization.jsonObject(with: JSONData, options: .allowFragments) as? [String: AnyObject]
                if let unwrappedJSON = JSON {
                    currentWeatherData = getCurrentData(JSON: unwrappedJSON)
                }
            }
            catch {
                print(error)
            }
        return currentWeatherData
    }
    
    func getHourlyData(JSON: [String: AnyObject]) -> [WeatherData] {
        var hourlyWeatherData = [WeatherData]()
        
        if let hourlyJSON = JSON["hourly"] as? [String: AnyObject] {
            if let hourlyData = hourlyJSON["data"] as? [[String: AnyObject]] {
                
                for data in hourlyData {
                    
                    var singleHourWeatherData = WeatherData(time: NSDate(), temperature: nil, summary: nil, apparentTemperature: nil, precipIntensity: nil, precipProbability: nil)
                    
                    if let time = data["time"] as? Double {
                        let unixTime = TimeInterval(time)
                        let humanTime = NSDate(timeIntervalSince1970: unixTime)
                        
                        singleHourWeatherData.time = humanTime
                    }
                    
                    if let temperature = data["temperature"] as? Double {
                        singleHourWeatherData.temperature = (singleHourWeatherData.getTemperature(temperature: temperature))
                    }
                    
                    if let summary = data["icon"] as? String {
                        singleHourWeatherData.summary = summary
                    }
                    
                    if let apparentTemperature = data["apparentTemperature"] as? Double {
                        singleHourWeatherData.apparentTemperature = apparentTemperature
                    }
                    
                    if let precipIntensity = data["precipIntensity"] as? Double {
                        singleHourWeatherData.precipIntensity = precipIntensity
                    }
                    
                    if let precipProbability = data["precipProbability"] as? Double {
                        singleHourWeatherData.precipProbability = precipProbability
                    }
                    
                    hourlyWeatherData.append(singleHourWeatherData)
                    }
                }
            }
        return hourlyWeatherData
    }
    
    func getCurrentData(JSON: [String: AnyObject]) -> WeatherData {
        var singleHourWeatherData = WeatherData(time: NSDate(), temperature: nil, summary: nil, apparentTemperature: nil, precipIntensity: nil, precipProbability: nil)
        
        if let data = JSON["currently"] as? [String: AnyObject] {
            
            if let time = data["time"] as? Double {
                let unixTime = TimeInterval(time)
                let humanTime = NSDate(timeIntervalSince1970: unixTime)
                
                singleHourWeatherData.time = humanTime
            }
            
            if let temperature = data["temperature"] as? Double {
                singleHourWeatherData.temperature = (singleHourWeatherData.getTemperature(temperature: temperature))
            }
            
            if let summary = data["summary"] as? String {
                singleHourWeatherData.summary = summary
            }
            
            if let apparentTemperature = data["apparentTemperature"] as? Double {
                singleHourWeatherData.apparentTemperature = apparentTemperature
            }
            
            if let precipIntensity = data["precipIntensity"] as? Double {
                singleHourWeatherData.precipIntensity = precipIntensity
            }
            
            if let precipProbability = data["precipProbability"] as? Double {
                singleHourWeatherData.precipProbability = precipProbability
            }
    
        }
        return singleHourWeatherData
    }

}
