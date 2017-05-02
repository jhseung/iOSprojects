//
//  RainAnimation.swift
//  FinalProject
//
//  Created by Ji Hwan Seung on 24/04/2017.
//  Copyright © 2017 Ji Hwan Seung. All rights reserved.
//

import UIKit
import SpriteKit

class RainAnimationView {
    
    var view: UIView!
    private var drops = [UIView]()
    var dropColor = Gradient().changeToCGColor(hexcode: "4E85EB")
    
    private var initialX: CGFloat!
    private var initialY: CGFloat!
    private var dropDistanceBetween: CGFloat!
    private var dropDistanceHeight: CGFloat!
    
    private var animator: UIDynamicAnimator!
    private var gravityBehavior = UIGravityBehavior()
    private var timer1 = Timer()
    private var timer2 = Timer()
    
    init(view: UIView) {
        
        self.view = view
        let width = self.view.frame.width
        
        initialX = 20
        initialY = -60
        dropDistanceBetween = width * 0.05
        dropDistanceHeight = dropDistanceBetween * 2
        
        animator = UIDynamicAnimator(referenceView: self.view)
        gravityBehavior.gravityDirection.dy = 4
        animator.addBehavior(gravityBehavior)
        
    }
    
    func rain() {
        timer1 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(spawnDrops), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(startTimer2), userInfo: nil, repeats: false)
    }
    
    private func addGravity(array: [UIView]) {
        for drop in array {
            gravityBehavior.addItem(drop)
        }
        var i = 0
        
        while true {
            if drops[i].frame.origin.y > self.view.frame.height {
                gravityBehavior.removeItem(drops[i])
                drops[i].removeFromSuperview()
                drops.remove(at: i)
            }
            i = i + 1
            if i > drops.count - 1 {
                break
            }
        }
    }
    
    @objc private func spawnDrops() {
        
        var dropsArray = [UIView]()
        
        let numberOfDrops = 3
        
        for _ in 0 ..< numberOfDrops {
            
            let newY = CGFloat(-200 + Int(arc4random_uniform(UInt32(150))))
            let newX = CGFloat(Int(arc4random_uniform(UInt32(400))))
            
            let drop = UIView(frame: CGRect(x: newX, y: newY, width: 1.0, height: 40.0))
            drop.alpha = 0.4
            drop.backgroundColor = UIColor(cgColor: dropColor)
            drop.layer.borderWidth = 0
            
            self.view.addSubview(drop)
            self.drops.append(drop)
            dropsArray.append(drop)
        }
        
        addGravity(array: dropsArray)
    }
    
    @objc private func startTimer2() {
        timer2 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(spawnDrops), userInfo: nil, repeats: true)
    }
}
