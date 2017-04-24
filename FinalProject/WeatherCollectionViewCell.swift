//
//  MiniWeatherView.swift
//  FinalProject
//
//  Created by Ji Hwan Seung on 18/04/2017.
//  Copyright © 2017 Ji Hwan Seung. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    var weatherIcon: UIImageView!
    var degreeLabel: UILabel!
    var timeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addLayout()
        
    }
    
    func addLayout() {
        
        timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: 20))
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont(name: "JosefinSans-Light", size: 20)
        
        weatherIcon = UIImageView(frame: CGRect(x: 0, y: timeLabel.frame.height + 10, width: 40, height: 40))
        weatherIcon.center.x = contentView.center.x
        weatherIcon.clipsToBounds = true
        weatherIcon.contentMode = .scaleAspectFill
        
        degreeLabel = UILabel(frame: CGRect(x: 0, y: weatherIcon.frame.origin.y + weatherIcon.frame.height + 20, width: frame.width, height: 30))
        degreeLabel.textAlignment = .center
        degreeLabel.font = UIFont(name: "JosefinSans-Light", size: 30)
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(degreeLabel)
        
    }
    
    override func prepareForReuse() {
        weatherIcon.image = nil
        degreeLabel.text = nil
        timeLabel.text = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
