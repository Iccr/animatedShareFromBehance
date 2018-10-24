//
//  ViewController.swift
//  animatedShareBehance
//
//  Created by gme_2 on 22/10/2018.
//  Copyright © 2018 gme_2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // middle view
    var middleLineView: UIView?
    var middleComplementaryLineView: UIView?
    var middleCircle: UIView?
    
    
    // left view
    var leftLineView: UIView?
    var leftComplementaryLineView: UIView?
    var leftCircle: UIView?
    
    // right view
    var rightLineView: UIView?
    var rightComplementaryLineView: UIView?
    var rightCircle: UIView?
    
    
    
    @IBOutlet weak var playButton: UIButton!
    
    let cubicTimingParameters = UICubicTimingParameters.init(controlPoint1: CGPoint.init(x:  0.99, y:  0.1), controlPoint2: CGPoint.init(x: 0.99, y: 0.92))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
        animate()
    }


    
    
    func setup() {
        // left view
        var width = self.view.bounds.width * 0.25
        var origin = CGPoint.init(x: width, y: 30)
        let leftLineView = self.createViewAt(center: origin, isComplementary: false)
        let leftComplimentaryView = self.createViewAt(center: origin, isComplementary: true)
        self.leftLineView = leftLineView
        self.leftComplementaryLineView = leftComplimentaryView
        self.view.addSubview(leftLineView)
        self.view.addSubview(leftComplimentaryView)
        
//        middle view
        
        width = self.view.bounds.width * 0.5
        origin = CGPoint.init(x: width, y: 30)
        let middleLineView = self.createViewAt(center: origin, isComplementary: false)
        let middleComplimentaryView = self.createViewAt(center: origin, isComplementary: true)
        self.middleLineView = middleLineView
        self.middleComplementaryLineView = middleComplimentaryView
        self.view.addSubview(middleLineView)
        self.view.addSubview(middleComplimentaryView)
        
        // right view
        width = self.view.bounds.width * 0.75
        origin = CGPoint.init(x: width, y: 30)
        let rightLineView = self.createViewAt(center: origin, isComplementary: false)
        let rightComplimentaryView = self.createViewAt(center: origin, isComplementary: true)
        self.rightLineView = rightLineView
        self.rightComplementaryLineView = rightComplimentaryView
        self.view.addSubview(rightLineView)
        self.view.addSubview(rightComplimentaryView)
        
        
    }
    
    func createViewAt(center: CGPoint, isComplementary: Bool) -> UIView {
        let rect = CGRect.init(origin: center, size: CGSize.init(width: 2, height: 20))
        let view = UIView.init(frame: rect)
        view.center = center
        view.backgroundColor = isComplementary ? .white : .red
        return view
    }
    
    @IBAction func play(_ sender: UIButton) {
        dispose()
        setup()
        animate()
    }
    
    func dispose() {
        // left view
        self.leftComplementaryLineView?.removeFromSuperview()
        self.leftLineView?.removeFromSuperview()
        self.leftCircle?.removeFromSuperview()
        
        // middle view
        self.middleComplementaryLineView?.removeFromSuperview()
        self.middleLineView?.removeFromSuperview()
        self.middleCircle?.removeFromSuperview()
        
        // right view
        self.rightComplementaryLineView?.removeFromSuperview()
        self.rightLineView?.removeFromSuperview()
        self.rightCircle?.removeFromSuperview()
        
        self.playButton.isUserInteractionEnabled = true
    }
    
    
    func getCenterOfCircle(for view: UIView?) -> CGPoint {
        let x = view?.frame.minX ?? 0
        let y = view?.frame.maxY ?? 0
        return CGPoint.init(x: x, y: y)
    }
    
    func animate() {
        self.playButton.isUserInteractionEnabled = false
        
        let duration: TimeInterval = 1
        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: self.cubicTimingParameters)
        
        animator.addAnimations {
            self.middleLineView?.transform = CGAffineTransform.init(scaleX: 1, y: 30)
            self.leftLineView?.transform = CGAffineTransform.init(scaleX: 1, y: 30)
            self.rightLineView?.transform = CGAffineTransform.init(scaleX: 1, y: 30)
        }
        animator.addCompletion { (_) in
            
            CATransaction.begin()
            self.animateCircle(center: self.getCenterOfCircle(for: self.middleLineView), at: 1) // 0 for left, 1 for middle and 2 fir right
            self.animateCircle(center: self.getCenterOfCircle(for: self.leftLineView), at:  0)
            self.animateCircle(center: self.getCenterOfCircle(for: self.rightLineView), at: 2)
            
            self.view.bringSubviewToFront(self.middleComplementaryLineView!)
            self.view.bringSubviewToFront(self.middleCircle!)
            
            self.view.bringSubviewToFront(self.rightComplementaryLineView!)
            self.view.bringSubviewToFront(self.rightCircle!)
            
            self.view.bringSubviewToFront(self.leftComplementaryLineView!)
            self.view.bringSubviewToFront(self.leftCircle!)
            
            let animator = UIViewPropertyAnimator(duration: 0.3, timingParameters: self.cubicTimingParameters)
            animator.addAnimations {
                self.middleComplementaryLineView?.transform = CGAffineTransform.init(scaleX: 1, y: 29.8)
                self.leftComplementaryLineView?.transform = CGAffineTransform.init(scaleX: 1, y: 29.8)
                self.rightComplementaryLineView?.transform = CGAffineTransform.init(scaleX: 1, y: 29.8)
            }
            CATransaction.setCompletionBlock({
                self.playButton.isUserInteractionEnabled = true
            })
            CATransaction.commit()
            animator.startAnimation()
        }
        animator.startAnimation()
    }
    
    func animateCircle(center: CGPoint?, at position: Int) {  // 0 for left, 1 for middle and 2 for right
        guard let center = center else {return}
        let circularPath = UIBezierPath.init(arcCenter: center, radius: 5, startAngle: 0, endAngle: 360, clockwise: true)
        let finalCirclePath = UIBezierPath.init(arcCenter: center, radius: 20, startAngle: 0, endAngle: 360, clockwise: true)
        
        let circularShape = CAShapeLayer()
        circularShape.path = circularPath.cgPath
        circularShape.lineCap = .round
        circularShape.lineWidth = 2
        circularShape.strokeColor = UIColor.red.cgColor
        circularShape.fillColor = UIColor.white.cgColor
        
        
        let animation = CABasicAnimation.init(keyPath: "path")
        animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.fromValue = circularPath.cgPath
        animation.toValue = finalCirclePath.cgPath
        animation.duration = 0.6
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        circularShape.add(animation, forKey: "path")
        let circle = UIView()
        circle.layer.addSublayer(circularShape)
        switch position {
        case 0:
            self.leftCircle = circle
        case 1:
            self.middleCircle = circle
        default:
            self.rightCircle = circle
        }
        self.view.addSubview(circle)
    }
}



