//
//  FutureCollectionView.swift
//  FinalProject
//
//  Created by Ji Hwan Seung on 19/04/2017.
//  Copyright © 2017 Ji Hwan Seung. All rights reserved.
//

import UIKit

class FutureWeatherView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let futureWeatherCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weather")
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = futureWeatherCollectionView.dequeueReusableCell(withReuseIdentifier: "weather", for: indexPath) as! WeatherCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: frame.height)
    }
    
    func setupViews() {
        
        addSubview(futureWeatherCollectionView)
        
        futureWeatherCollectionView.dataSource = self
        futureWeatherCollectionView.delegate = self
        
        
    }
    
}
