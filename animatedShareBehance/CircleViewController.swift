//
//  CircleViewController.swift
//  animatedShareBehance
//
//  Created by gme_2 on 23/10/2018.
//  Copyright © 2018 gme_2. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {

    @IBOutlet weak var screen: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        

        
        let center = self.view.center
        let circularPath = UIBezierPath.init(arcCenter: center, radius: 10, startAngle: 0, endAngle: 360, clockwise: true)
        let finalCirclePath = UIBezierPath.init(arcCenter: center, radius: 40, startAngle: 0, endAngle: 360, clockwise: true)
        
        let circularShape = CAShapeLayer()
        circularShape.path = circularPath.cgPath
        circularShape.lineCap = .round
        circularShape.lineWidth = 2
        circularShape.strokeColor = UIColor.red.cgColor
        circularShape.fillColor = UIColor.white.cgColor
        

        
        
        let animation = CABasicAnimation.init(keyPath: "path")
        animation.fromValue = circularPath.cgPath
        animation.toValue = finalCirclePath.cgPath
        animation.duration = 3
        animation.autoreverses = false
        animation.repeatCount = .greatestFiniteMagnitude
        animation.fillMode = .removed
        circularShape.add(animation, forKey: "path")
        
        let circle = UIView()
        circle.layer.addSublayer(circularShape)
        self.view.addSubview(circle)
        

//        let shapeLayer = CAShapeLayer()
//        shapeLayer.fillColor = UIColor.white.cgColor
//        shapeLayer.strokeColor = UIColor.red.cgColor
//
//        shapeLayer.path = starPath.cgPath
//        let pathAnimation = CABasicAnimation.init(keyPath: "path")
//        pathAnimation.toValue = rectanglePath.cgPath
//        pathAnimation.duration = 1
//        pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        pathAnimation.autoreverses = true
//        pathAnimation.repeatCount = .greatestFiniteMagnitude
//        shapeLayer.add(pathAnimation, forKey: "path")
//
//        let animationView = UIView()
//        animationView.layer.addSublayer(shapeLayer)
//        animationView.center = self.view.center
//        self.view.addSubview(animationView)
        
    }
}
