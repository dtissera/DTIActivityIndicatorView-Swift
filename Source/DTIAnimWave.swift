//
//  DTIAnimWave.swift
//  SampleObjc
//
//  Created by dtissera on 16/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit
import QuartzCore

class DTIAnimWave: DTIAnimProtocol {
    /** private properties */
    private let owner: DTIActivityIndicatorView
    
    private let spinnerView = UIView()
    private let rectView = UIView()
    private let animationDuration = CFTimeInterval(1.2)
    private let spaceBetweenRect: CGFloat = 3.0
    private let rectCount = 5
    
    /** ctor */
    init(indicatorView: DTIActivityIndicatorView) {
        self.owner = indicatorView
        for index in 0 ..< rectCount {
            let layer = CALayer()
            layer.transform = CATransform3DMakeScale(1.0, 0.4, 0.0);
            
            self.rectView.layer.addSublayer(layer)
        }
    }
    
    // -------------------------------------------------------------------------
    // DTIAnimProtocol
    // -------------------------------------------------------------------------
    func needLayoutSubviews() {
        self.spinnerView.frame = self.owner.bounds
        
        let contentSize = self.owner.bounds.size
        let rectWidth: CGFloat = (contentSize.width - spaceBetweenRect * CGFloat(rectCount-1)) / CGFloat(rectCount)
        
        self.rectView.frame = self.owner.bounds;

        for index in 0 ..< rectCount {
            let rectLayer = self.rectView.layer.sublayers![index] as CALayer
            rectLayer.frame = CGRect(x: CGFloat(index)*(rectWidth+spaceBetweenRect), y: 0.0, width: rectWidth, height: contentSize.height)
        }
    }
    
    func needUpdateColor() {
        // Debug stuff
        // self.spinnerView.backgroundColor = UIColor.grayColor()
        
        for index in 0 ..< rectCount {
            let rectLayer = self.rectView.layer.sublayers![index] as CALayer
            rectLayer.backgroundColor = self.owner.indicatorColor.cgColor
        }
    }
    
    
    func setUp() {
        self.spinnerView.addSubview(self.rectView)
    }
    
    func startActivity() {
        self.owner.addSubview(self.spinnerView)
        
        let beginTime = CACurrentMediaTime() + self.animationDuration;
        for index in 0 ..< rectCount {
            let rectLayer = self.rectView.layer.sublayers![index] as CALayer

            let aniScale = CAKeyframeAnimation()
            aniScale.keyPath = "transform"
            aniScale.isRemovedOnCompletion = false
            aniScale.repeatCount = HUGE
            aniScale.duration = self.animationDuration
            aniScale.beginTime = beginTime - self.animationDuration + CFTimeInterval(index) * 0.1;
            aniScale.keyTimes = [0.0, 0.2, 0.4, 1.0];
            aniScale.timingFunctions = [
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            ]
            aniScale.values = [
                NSValue(caTransform3D: CATransform3DMakeScale(1.0, 0.4, 0.0)),
                NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 0.0)),
                NSValue(caTransform3D: CATransform3DMakeScale(1.0, 0.4, 0.0)),
                NSValue(caTransform3D: CATransform3DMakeScale(1.0, 0.4, 0.0))
            ]
            
            rectLayer.add(aniScale, forKey: "DTIAnimWave~scale\(index)")
        }
    }
    
    func stopActivity(_ animated: Bool) {
        func removeAnimations() {
            self.spinnerView.layer.removeAllAnimations()
            for index in 0 ..< rectCount {
                let rectLayer = self.rectView.layer.sublayers![index] as CALayer
                rectLayer.removeAllAnimations()
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
