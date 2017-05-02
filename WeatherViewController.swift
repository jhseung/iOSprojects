//
//  ViewController.swift
//  FinalProject
//
//  Created by Ji Hwan Seung on 17/04/2017.
//  Copyright © 2017 Ji Hwan Seung. All rights reserved.
//

import UIKit
import SpriteKit
import SwiftyJSON
import Foundation

protocol WeatherViewControllerDelegate {
    func addCityButtonWasTapped()
}

class WeatherViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var layoutView: WeatherView!
    var hourlyForecastView: UICollectionView!
    var weatherAPI = NetworkRequest()
    var hourlyWeatherData = [WeatherDataRealm]()
    var currentWeatherData: WeatherDataRealm!
    var city: City!
    
    var addCityButton: UIButton!
    
    var isFahrenheit: Bool = false
    var isRaining: Bool = false
    
    var rainAnimation: RainAnimationView!
    var originalLocation = CGPoint()

    var json: JSON!
    
    var delegate: WeatherViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherAPI.latitude = String(city.latitude)
        weatherAPI.longtitude = String(city.longtitude)
        weatherAPI.fetchData { (json: JSON) in
            self.json = json
            
            self.currentWeatherData = NetworkRequest.parseCurrentWeatherData(json: json)
            self.hourlyWeatherData = NetworkRequest.parseHourlyData(json: json)

            
            
            self.layoutSubviews()
        }
        
    }
    
    func addCityButtonWasTapped() {
        delegate.addCityButtonWasTapped()
        print("button tapped")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func layoutSubviews() {
        
        // Setup background animation
        if let summary = currentWeatherData["summary"] as? String {
            if summary == "rain" {
                isRaining = true
            }
        }
        
        if isRaining {
            rainAnimation = RainAnimationView(view: self.view)
            rainAnimation.rain()
        }
        
        // Setup background gradient
        setupGradient()
        
        // Setting up base view with current information
        layoutView = WeatherView(frame: view.frame)
        layoutView.isUserInteractionEnabled = false
        
        let temperature = currentWeatherData.temperature
        
        if isFahrenheit {
            layoutView.degreeLabel.text = "\(String(Int(round(temperature))))°"
        } else {
            let temperatureCelsius = (temperature - 32) * (5 / 9)
            layoutView.degreeLabel.text = "\(String(Int(round(temperatureCelsius))))°"
        }
        
        layoutView.weatherStatusLabel.text = currentWeatherData.summary
        layoutView.cityLabel.text = city.name.uppercased()
        
        
        // Timer to update time
        let timer = Timer.scheduledTimer(timeInterval: 1, target: layoutView, selector: #selector(layoutView.updateTime), userInfo: nil, repeats: true)
        timer.fire()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        hourlyForecastView = UICollectionView(frame: CGRect(x: 0, y: 400, width: view.frame.width, height: 130), collectionViewLayout: layout)
        hourlyForecastView.backgroundColor = UIColor.clear
        hourlyForecastView.dataSource = self
        hourlyForecastView.delegate = self
        hourlyForecastView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weather")
        hourlyForecastView.showsHorizontalScrollIndicator = false
        
        addCityButton = UIButton(frame: CGRect(x: view.frame.width - 20, y: 0, width: 20, height: 20))
        addCityButton.addTarget(self, action: #selector(addCityButtonWasTapped), for: .touchUpInside)
        addCityButton.backgroundColor = .black
        
        view.insertSubview(addCityButton, aboveSubview: layoutView)
        view.addSubview(hourlyForecastView)
        view.addSubview(layoutView)
        
    }
    
    func setupGradient() {
        
        let gradient = Gradient()
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if hour < 5 {
            gradientLayer.colors = gradient.colorSets["night"]
        } else if hour < 7 {
            gradientLayer.colors = gradient.colorSets["dawn"]
        } else if hour < 10 {
            gradientLayer.colors = gradient.colorSets["sunset"]
        } else if hour < 18 {
            gradientLayer.colors = gradient.colorSets["day"]
        } else if hour < 20 {
            gradientLayer.colors = gradient.colorSets["sunset"]
        } else if hour < 21 {
            gradientLayer.colors = gradient.colorSets["dawn"]
        } else {
            gradientLayer.colors = gradient.colorSets["night"]
        }
        
        self.view.layer.addSublayer(gradientLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view) {
            originalLocation = location
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view) {
            changeBackground(previousLocation: originalLocation, location: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = hourlyForecastView.dequeueReusableCell(withReuseIdentifier: "weather", for: indexPath) as? WeatherCollectionViewCell {
            
            let summary = hourlyWeatherData[indexPath.row].summary
                if summary == "clear-day" {
                    cell.weatherIcon.image = #imageLiteral(resourceName: "016-sunny-day")
                } else if summary == "rain" {
                    cell.weatherIcon.image = #imageLiteral(resourceName: "008-rainy-day")
                } else if summary == "clear-night" {
                    cell.weatherIcon.image = #imageLiteral(resourceName: "010-night")
                } else if summary == "snow" {
                    cell.weatherIcon.image = #imageLiteral(resourceName: "005-hail-storm")
                } else if summary == "sleet" {
                    cell.weatherIcon.image = #imageLiteral(resourceName: "004-sleet")
                } else if summary == "wind" {
                    cell.weatherIcon.image = #imageLiteral(resourceName: "014-windy-day")
                } else if summary == "fog" {
                    cell.weatherIcon.image = #imageLiteral(resourceName: "019-overcast-day")
                } else if summary == "cloudy" {
                    cell.weatherIcon.image = #imageLiteral(resourceName: "019-overcast-day")
                } else if summary == "partly-cloudy-day" {
                    cell.weatherIcon.image = #imageLiteral(resourceName: "018-cloudy-day")
                } else if summary == "partly-cloudy-night" {
                    cell.weatherIcon.image = #imageLiteral(resourceName: "011-dark-night")
                }
            
            
            if let time = hourlyWeatherData[indexPath.row].time {
                let timeFormat = DateFormat()
                cell.timeLabel.text = timeFormat.getHour(time: time)
            }
            
            let temperature = hourlyWeatherData[indexPath.row].temperature
            
            if isFahrenheit {
                cell.degreeLabel.text = "\(String(Int(round(temperature))))°"
            } else {
                let temperatureCelsius = (temperature - 32) * (5 / 9)
                cell.degreeLabel.text = "\(String(Int(round(temperatureCelsius))))°"
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
    
    func changeBackground(previousLocation: CGPoint, location: CGPoint) {
        let alpha = (location.x - previousLocation.x) / 300
    }
    
}

