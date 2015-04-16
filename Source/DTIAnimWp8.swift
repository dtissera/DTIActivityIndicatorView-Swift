//
//  DTIAnimWp8.swift
//  SampleObjc
//
//  Created by dtissera on 17/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit
import QuartzCore

class DTIAnimWp8: DTIAnimProtocol {
    /** private properties */
    private let owner: DTIActivityIndicatorView
    
    private let spinnerView = UIView()
    private let ballCount = 5
    private let animationDuration = CFTimeInterval(7.15)
    
    /** ctor */
    init(indicatorView: DTIActivityIndicatorView) {
        self.owner = indicatorView
        
        for var index = 0; index < ballCount; ++index {
            let layer = CALayer()
            let layerBall = CALayer()
            layer.opacity = 0.0
            layer.addSublayer(layerBall)
            
            self.spinnerView.layer.addSublayer(layer)
        }
    }

    // -------------------------------------------------------------------------
    // DTIAnimProtocol
    // -------------------------------------------------------------------------
    func needLayoutSubviews() {
        self.spinnerView.frame = self.owner.bounds
        
        let ballSize = CGFloat(self.owner.bounds.width / 9)
        
        for var index = 0; index < ballCount; ++index {
            let layer = self.spinnerView.layer.sublayers[index] as! CALayer
            let layerBall = layer.sublayers[0] as! CALayer
            
            layer.frame = self.owner.bounds
            layerBall.frame = CGRect(x: ballSize, y: ballSize, width: ballSize, height: ballSize)
            
            layerBall.cornerRadius = layerBall.frame.size.width/2
        }
    }
    
    func needUpdateColor() {
        // Debug stuff
        // self.spinnerView.backgroundColor = UIColor.grayColor()
        
        for item in self.spinnerView.layer.sublayers {
            let layer = item as! CALayer
            let layerBall = layer.sublayers[0] as! CALayer
            
            //layer.backgroundColor = UIColor.grayColor().CGColor
            layerBall.backgroundColor = self.owner.indicatorColor.CGColor
        }
    }
    
    func setUp() {
        //self.spinnerView.layer.shouldRasterize = true
    }
    
    func startActivity() {
        self.owner.addSubview(self.spinnerView)
        
        let beginTime = CACurrentMediaTime();
        let delays = [CFTimeInterval(1.56), CFTimeInterval(0.31), CFTimeInterval(0.62), CFTimeInterval(0.94), CFTimeInterval(1.25)]
        for var index = 0; index < ballCount; ++index {
            let layer = self.spinnerView.layer.sublayers[index] as! CALayer
            
            let anim = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            anim.duration = self.animationDuration
            // 180, 300, 410, 645, 770, 900, 900, 900
            // 1, 1, 1, 1, 1, 1, 0, 0
            // o, l, in, l, o, o, _, _
            anim.keyTimes = [0.0, 0.07, 0.3, 0.39, 0.7, 0.75, 0.76, 1.0]
            anim.timingFunctions = [
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault),
            ]
            var rotationsValues = [CGFloat(M_PI)]
            rotationsValues.append(CGFloat(rotationsValues[rotationsValues.count-1]) + CGFloat(M_PI*(300.0-180.0)/180.0))
            rotationsValues.append(CGFloat(rotationsValues[rotationsValues.count-1]) + CGFloat(M_PI*(410.0-300.0)/180.0))
            rotationsValues.append(CGFloat(rotationsValues[rotationsValues.count-1]) + CGFloat(M_PI*(645.0-410.0)/180.0))
            rotationsValues.append(CGFloat(rotationsValues[rotationsValues.count-1]) + CGFloat(M_PI*(770.0-645.0)/180.0))
            rotationsValues.append(CGFloat(rotationsValues[rotationsValues.count-1]) + CGFloat(M_PI*(900.0-770.0)/180.0))
            rotationsValues.append(CGFloat(rotationsValues[rotationsValues.count-1]) + CGFloat(0))
            rotationsValues.append(CGFloat(rotationsValues[rotationsValues.count-1]) + CGFloat(0))
            anim.values = rotationsValues
            
            let aniOpacity = CAKeyframeAnimation(keyPath: "opacity")
            aniOpacity.values = [0.0, 1.0, 0.0]
            aniOpacity.keyTimes = [0.0, 0.07, 0.3, 0.39, 0.7, 0.75, 0.76, 1.0]
            aniOpacity.values = [0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0]
            
            let aniGroup = CAAnimationGroup();
            aniGroup.fillMode = kCAFillModeForwards;
            aniGroup.removedOnCompletion = false
            aniGroup.repeatCount = HUGE
            aniGroup.duration = self.animationDuration;
            aniGroup.animations = [anim, aniOpacity];
            aniGroup.beginTime = beginTime + delays[index]

            layer.addAnimation(aniGroup, forKey: nil)
        }
    }
    
    func stopActivity(animated: Bool) {
        func removeAnimations() {
            self.spinnerView.layer.removeAllAnimations()

            for var index = 0; index < ballCount; ++index {
                let layer = self.spinnerView.layer.sublayers[index] as! CALayer
                layer.removeAllAnimations()
            }
            
            self.spinnerView.removeFromSuperview()
        }

        if (animated) {
            self.spinnerView.layer.dismissAnimated(removeAnimations)
        }
        else {
            removeAnimations()
        }
        
    }
}

