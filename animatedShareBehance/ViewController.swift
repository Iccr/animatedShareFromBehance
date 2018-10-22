//
//  ViewController.swift
//  animatedShareBehance
//
//  Created by gme_2 on 22/10/2018.
//  Copyright © 2018 gme_2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var origin: CGPoint?

    var lineView: UIView?
    var complementaryLineView: UIView?
    var circleView: UIView?
    var innerView: UIView?
    
    let cubicTimingParameters = UICubicTimingParameters.init(controlPoint1: CGPoint.init(x:  0.99, y:  0.1), controlPoint2: CGPoint.init(x: 0.99, y: 0.92))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupInitialPoint()
        setup()
        animate()
    }


    func setupInitialPoint() {
        let width = self.view.bounds.width * 0.5
        self.origin = CGPoint.init(x: width, y: 30)
    }
    
    
    func setup() {
        guard let origin = self.origin else {return}
        let rect = CGRect.init(origin: origin, size: CGSize.init(width: 2, height: 20))
        let lineView = UIView.init(frame: rect)
        lineView.center = origin
        self.lineView = lineView
        lineView.backgroundColor = UIColor.red
        
        let complimentaryView = UIView.init(frame: rect)
        complimentaryView.center = origin
        self.complementaryLineView = complimentaryView
        complimentaryView.backgroundColor = .white
        self.view.addSubview(complimentaryView)
        self.view.addSubview(lineView)
        
    }
    
    @IBAction func play(_ sender: UIButton) {
        self.complementaryLineView?.removeFromSuperview()
        self.lineView?.removeFromSuperview()
        self.circleView?.removeFromSuperview()

        setupInitialPoint()
        setup()
        animate()
        
    }
    
    
    func animate() {
        
        let duration: TimeInterval = 1
        
        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: self.cubicTimingParameters)
        
        animator.addAnimations {
            self.lineView?.transform = CGAffineTransform.init(scaleX: 1, y: 30)
        }
    
        animator.addCompletion { (_) in
            let circleView = self.getCircleView()
            
            
            self.view.bringSubviewToFront(self.complementaryLineView!)
            self.view.bringSubviewToFront(circleView)
            self.view.bringSubviewToFront(self.innerView!)
            let animator = UIViewPropertyAnimator(duration: 0.3, timingParameters: self.cubicTimingParameters)
            
            
            animator.addAnimations {
                circleView.transform = CGAffineTransform.init(scaleX: 10, y: 10)
                self.innerView?.transform = CGAffineTransform.init(scaleX: 10, y: 10)
                self.complementaryLineView?.transform = CGAffineTransform.init(scaleX: 1, y: 29.8)
            }
            
            animator.startAnimation()
        }
        
        animator.startAnimation()

    }
    
    func getCircleView() -> UIView {
        let x1 = self.lineView?.frame.minX ?? 0
        let y1 = self.lineView?.frame.maxY ?? 0
        
        let center = CGPoint.init(x: x1, y: y1)
        
        self.circleView = UIView()
        self.circleView?.center = center
        self.circleView?.frame = CGRect.init(origin: center, size: CGSize.init(width: 10, height: 10))
        self.circleView?.backgroundColor = .red

        let innerView = UIView()
        innerView.center = center
        innerView.frame = CGRect.init(origin: center, size: CGSize.init(width: 9.7, height: 9.7))
        self.innerView = innerView
        innerView.backgroundColor = .white
        innerView.layer.cornerRadius = innerView.bounds.width/2
        
        self.circleView?.layer.cornerRadius =  (self.circleView?.bounds.width ?? 0)/2
        self.view.addSubview(circleView!)
        self.view.addSubview(innerView)
        
        return circleView ?? UIView()
    }
}

//
//class CircularRing: UIView {
//    override func draw(_ rect: CGRect) {
//
//        let path = UIBezierPath.init(ovalIn: rect)
//        UIColor.white.setFill()
//        let desiredBorderColor = UIColor.red
//        desiredBorderColor.setStroke()
//
//        path.lineWidth = 1
//        path.fill()
//        path.stroke()
//
//    }
//}
