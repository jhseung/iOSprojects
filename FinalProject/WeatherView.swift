//
//  WeatherView.swift
//  FinalProject
//
//  Created by Ji Hwan Seung on 18/04/2017.
//  Copyright © 2017 Ji Hwan Seung. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    var degreeLabel: UILabel!
    var cityLabel: UILabel!
    var weatherStatusLabel: UILabel!
    var timeLabel: UILabel!
    var dateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addLayout()
        


    }
    
    func addLayout() {
        
        timeLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 150, height: 25))
        timeLabel.textAlignment = .left
        timeLabel.font = UIFont(name: "JosefinSans-Light", size: 22)
        
        dateLabel = UILabel(frame: CGRect(x: timeLabel.frame.origin.x, y: timeLabel.frame.origin.y + timeLabel.frame.height + 5, width: timeLabel.frame.width, height: timeLabel.frame.height))
        dateLabel.textAlignment = .left
        dateLabel.font = UIFont(name: "JosefinSans-Light", size: 22)
        
        weatherStatusLabel = UILabel(frame: CGRect(x: timeLabel.frame.origin.x, y: dateLabel.frame.origin.y + dateLabel.frame.height + 5, width: timeLabel.frame.width, height: timeLabel.frame.height*2))
        weatherStatusLabel.textAlignment = .left
        weatherStatusLabel.font = UIFont(name: "JosefinSans-Light", size: 30)
        
        degreeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 100))
        degreeLabel.center = CGPoint(x: center.x, y: center.y - 30)
        degreeLabel.textAlignment = .center
        degreeLabel.font = UIFont(name: "JosefinSans-Light", size: 80)
        
        cityLabel = UILabel(frame: CGRect(x: frame.width - 150, y: frame.height - 100, width: 130, height: 100))
        cityLabel.center.x = center.x
        cityLabel.textAlignment = .center
        cityLabel.font = UIFont(name: "JosefinSans-Light", size: 25)
        
        addSubview(degreeLabel)
        addSubview(timeLabel)
        addSubview(dateLabel)
        addSubview(weatherStatusLabel)
        addSubview(cityLabel)
        
        addData()
    }
    
    func addData() {
        
        timeLabel.text = "1:23 PM"
        
        dateLabel.text = "April 4, 2017"
        
        weatherStatusLabel.text = "Cloudy"
        
        degreeLabel.text = "17"
        
        cityLabel.text = "ITHACA"

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
