//
//  DTIAnimWanderingCubes.swift
//  SampleObjc
//
//  Created by dtissera on 20/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit
import QuartzCore

class DTIAnimWanderingCubes: DTIAnimProtocol {
    /** private properties */
    private let owner: DTIActivityIndicatorView
    
    private let spinnerView = UIView()
    private let animationDuration = CFTimeInterval(1.8)
    private let cubeCount = 2
    
    /** ctor */
    init(indicatorView: DTIActivityIndicatorView) {
        self.owner = indicatorView
        for _ in 0...cubeCount {
            let cubeLayer = CALayer()
            self.spinnerView.layer.addSublayer(cubeLayer)
        }
    }

    // -------------------------------------------------------------------------
    // DTIAnimProtocol
    // -------------------------------------------------------------------------
    func needLayoutSubviews() {
        self.spinnerView.frame = self.owner.bounds
        
        let cubeSize = CGFloat(floor(self.owner.bounds.width / 3.5))
        
        for  index in 0...cubeCount {
            let layer = self.spinnerView.layer.sublayers![index]
            layer.frame = CGRect(x: 0.0, y: 0.0, width: cubeSize, height: cubeSize)
        }
       
    }
    
    func needUpdateColor() {
        // Debug stuff
        // self.spinnerView.backgroundColor = UIColor.grayColor()
        
        for  index in 0...cubeCount {
            let cubeLayer = self.spinnerView.layer.sublayers![index]
            cubeLayer.backgroundColor = self.owner.indicatorColor.cgColor
        }
    }
    
    
    func setUp() {
        //self.spinnerView.layer.shouldRasterize = true
    }
    
    func startActivity() {
        self.owner.addSubview(self.spinnerView)
        
        let beginTime = CACurrentMediaTime();
        for  index in 0...cubeCount {
            let cubeLayer = self.spinnerView.layer.sublayers![index]
            let translation = self.spinnerView.bounds.size.width-cubeLayer.bounds.size.width
            
            let aniTransform = CAKeyframeAnimation(keyPath: "transform")
            aniTransform.isRemovedOnCompletion = false
            aniTransform.repeatCount = HUGE
            aniTransform.duration = self.animationDuration
            aniTransform.beginTime = beginTime - CFTimeInterval(CGFloat(index)*CGFloat(self.animationDuration)/CGFloat(cubeCount));
            aniTransform.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0];
            aniTransform.timingFunctions = [
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            ]
            
            let transform0 = CATransform3DIdentity;
            
            // -90°
            var transform1 = CATransform3DMakeTranslation(translation, 0.0, 0.0);
            transform1 = CATransform3DRotate(transform1, -CGFloat(M_PI/2), 0.0, 0.0, 1.0);
            transform1 = CATransform3DScale(transform1, 0.5, 0.5, 1.0);
            
            // -180°
            var transform2 = CATransform3DMakeTranslation(translation, translation, 0.0);
            transform2 = CATransform3DRotate(transform2, -CGFloat(M_PI), 0.0, 0.0, 1.0);
            transform2 = CATransform3DScale(transform2, 1.0, 1.0, 1.0);
            
            // -270°
            var transform3 = CATransform3DMakeTranslation(0.0, translation, 0.0);
            transform3 = CATransform3DRotate(transform3, -CGFloat(M_PI*9/6), 0.0, 0.0, 1.0);
            transform3 = CATransform3DScale(transform3, 0.5, 0.5, 1.0);
            
            // -360°
            var transform4 = CATransform3DMakeTranslation(0.0, 0.0, 0.0);
            transform4 = CATransform3DRotate(transform4, -CGFloat(2*M_PI), 0.0, 0.0, 1.0);
            transform4 = CATransform3DScale(transform4, 1.0, 1.0, 1.0);
            
            aniTransform.values = [transform0,transform1,transform2,transform3,transform4]
            
            cubeLayer.shouldRasterize = true
            cubeLayer.add(aniTransform, forKey: "DTIAnimWanderingCubes~transform\(index)")
        }
    }
    
    func stopActivity(animated: Bool) {
        func removeAnimations() {
            self.spinnerView.layer.removeAllAnimations()
            
            for  index in 0...cubeCount {
                let layer = self.spinnerView.layer.sublayers![index]
                layer.removeAllAnimations()
            }
            
            self.spinnerView.removeFromSuperview()
        }
        
        if (animated) {
            self.spinnerView.layer.dismissAnimated{
                removeAnimations()
            }
        }
        else {
            removeAnimations()
        }
        
    }
}
