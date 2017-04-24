//
//  ViewController.swift
//  FinalProject
//
//  Created by Ji Hwan Seung on 17/04/2017.
//  Copyright © 2017 Ji Hwan Seung. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var baseView: WeatherView!
    var futureView: UICollectionView!
    var weatherAPI = WeatherAPI()
    var hourlyWeatherData = [WeatherData]()
    var currentWeatherData: WeatherData!
    var isFahrenheit: Bool = false
    
    var originalLocation = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupGradient()
        
        weatherAPI.getData { (hourWeatherData: [WeatherData], currentWeatherData: WeatherData) in
            self.hourlyWeatherData = hourWeatherData
            self.currentWeatherData = currentWeatherData
            
            self.layoutSubviews()
        }
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func layoutSubviews() {
        
        // Setup background gradient

        
        // Setting up base view with current information
        
        baseView = WeatherView(frame: view.frame)
        baseView.isUserInteractionEnabled = false
        if let temperature = currentWeatherData.temperature {
            if isFahrenheit {
                baseView.degreeLabel.text = "\(String(Int(round(temperature["Fahrenheit"]!))))°"
            } else {
                baseView.degreeLabel.text = "\(String(Int(round(temperature["Celsius"]!))))°"
            }
        }
        if let currentWeatherSummary = currentWeatherData.summary {
            baseView.weatherStatusLabel.text = currentWeatherSummary
        }
        
        
        // TRYING TO SETUP TIMER
        
//        let calendar = Calendar.current
//        var minuteChange = calendar.dateComponents([.era, .year, .month, .day, .hour, .minute], from: Date())
//        minuteChange.minute = minuteChange.minute! + 1
//        let nextMinute = calendar.date(from: minuteChange)
//        
//        let timer = Timer.init(fireAt: nextMinute!, interval: 60, target: true, selector: #selector(baseView.addLayout), userInfo: nil, repeats: true)
//        //        let timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(baseView.addData), userInfo: nil, repeats: true)
//        timer.fire()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        futureView = UICollectionView(frame: CGRect(x: 0, y: 400, width: view.frame.width, height: 130), collectionViewLayout: layout)
        futureView.backgroundColor = UIColor.clear
        futureView.dataSource = self
        futureView.delegate = self
        futureView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weather")
        futureView.showsHorizontalScrollIndicator = false
        
        view.addSubview(futureView)
        view.addSubview(baseView)
        
    }
    
    func setupGradient() {
        
        let gradient = Gradient()
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = gradient.colorSets["day"]
        
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
        if let cell = futureView.dequeueReusableCell(withReuseIdentifier: "weather", for: indexPath) as? WeatherCollectionViewCell {
            
            if let summary = hourlyWeatherData[indexPath.row].summary {
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
            }
            
            if let time = hourlyWeatherData[indexPath.row].time {
                let timeFormat = DateFormat()
                cell.timeLabel.text = timeFormat.getHour(time: time)
            }
            
            if isFahrenheit {
                if let temperature = hourlyWeatherData[indexPath.row].temperature?["Fahrenheit"] {
                    cell.degreeLabel.text = "\(String(Int(round(temperature))))°"
                }
            } else {
                if let temperature = hourlyWeatherData[indexPath.row].temperature?["Celsius"] {
                    cell.degreeLabel.text = "\(String(Int(round(temperature))))°"
                }
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

