//
//  DTIAnimSpotify.swift
//  SampleObjc
//
//  Created by dtissera on 16/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit
import QuartzCore

class DTIAnimSpotify: DTIAnimProtocol {
    /** private properties */
    private let owner: DTIActivityIndicatorView
    
    private let spinnerView = UIView()
    private let circleView = UIView()
    private let animationDuration = CFTimeInterval(1.2)
    private let circleCount = 3
    
    /** ctor */
    init(indicatorView: DTIActivityIndicatorView) {
        self.owner = indicatorView
        
        for var index = 0; index < circleCount; ++index {
            let layer = CALayer()
            
            self.circleView.layer.addSublayer(layer)
        }
    }
    
    // -------------------------------------------------------------------------
    // DTIAnimProtocol
    // -------------------------------------------------------------------------
    func needLayoutSubviews() {
        self.spinnerView.frame = self.owner.bounds
        
        let contentSize = self.owner.bounds.size
        let circleWidth: CGFloat = contentSize.width / CGFloat(circleCount*2+1)
        let posY: CGFloat = (contentSize.height-circleWidth)/2
        
        self.circleView.frame = self.owner.bounds
        // self.spinnerView.layer.cornerRadius = circleWidth/2
        
        for var index = 0; index < circleCount; ++index {
            let circleLayer = self.circleView.layer.sublayers[index] as! CALayer
            circleLayer.frame = CGRect(x: circleWidth+CGFloat(index)*(circleWidth*2), y: posY, width: circleWidth, height: circleWidth)
            
            circleLayer.cornerRadius = circleWidth/2
            //circleLayer.transform = CATransform3DMakeScale(2.0, 2.0, 0.0);
        }
    }
    
    func needUpdateColor() {
        // Debug stuff
        // self.spinnerView.backgroundColor = UIColor.grayColor()

        for var index = 0; index < circleCount; ++index {
            let circleLayer = self.circleView.layer.sublayers[index] as! CALayer
            circleLayer.backgroundColor = self.owner.indicatorColor.CGColor
        }
    }
    
    func setUp() {
        self.spinnerView.addSubview(self.circleView)
        //self.spinnerView.layer.shouldRasterize = true
    }
    
    func startActivity() {
        self.owner.addSubview(self.spinnerView)

        let beginTime = CACurrentMediaTime() + self.animationDuration;
        for var index = 0; index < circleCount; ++index {
            let circleLayer = self.circleView.layer.sublayers[index] as! CALayer
            
            let aniScale = CAKeyframeAnimation()
            aniScale.keyPath = "transform.scale"
            aniScale.values = [1.0, 1.7, 1.0, 1.0]
            aniScale.removedOnCompletion = false
            aniScale.repeatCount = HUGE
            aniScale.beginTime = beginTime - self.animationDuration + CFTimeInterval(index) * 0.2;
            aniScale.keyTimes = [0.0, 0.2, 0.4, 1.0];
            aniScale.timingFunctions = [
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            ]
            aniScale.duration = self.animationDuration
            
            circleLayer.addAnimation(aniScale, forKey: "DTIAnimSpotify~scale")
        }
    }
    
    func stopActivity(animated: Bool) {
        func removeAnimations() {
            self.spinnerView.layer.removeAllAnimations()
            for var index = 0; index < circleCount; ++index {
                let circleLayer = self.circleView.layer.sublayers[index] as! CALayer
                circleLayer.removeAllAnimations()
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