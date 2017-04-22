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
    var weatherData = [WeatherData]()
    
    var originalLocation = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        weatherAPI.getData { (weatherData: [WeatherData]) in
            self.weatherData = weatherData
            
            DispatchQueue.main.async {
                print ("done parsing")
                print (weatherData[0].time)
            }
        }
        
 
        
        layoutSubviews()
        
       
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func layoutSubviews() {
        baseView = WeatherView(frame: view.frame)
        baseView.isUserInteractionEnabled = false

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        futureView = UICollectionView(frame: CGRect(x: 0, y: 400, width: view.frame.width, height: 130), collectionViewLayout: layout)
        futureView.dataSource = self
        futureView.delegate = self
        futureView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weather")
        
        
        view.addSubview(futureView)
        view.addSubview(baseView)
        
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
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = futureView.dequeueReusableCell(withReuseIdentifier: "weather", for: indexPath) as? WeatherCollectionViewCell {
            
            cell.weatherIcon.image = UIImage(named: "sunny")
            cell.timeLabel.text = "5:00PM"
            
            return cell
            
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
    
    func changeBackground(previousLocation: CGPoint, location: CGPoint) {
        let alpha = (location.x - previousLocation.x) / 300
        print (alpha)
    }
    
    
    
}

