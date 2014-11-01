//
//  DTIAnimRotatingPlane.swift
//  SampleApplication
//
//  Created by dtissera on 15/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit
import QuartzCore

class DTIAnimRotatingPlane: DTIAnimProtocol {
    /** private properties */
    private let owner: DTIActivityIndicatorView
    
    private let spinnerView = UIView()
    private let planeView = UIView()
    
    /** ctor */
    init(indicatorView: DTIActivityIndicatorView) {
        self.owner = indicatorView
    }
    
    func transformPlane(perspective:CGFloat, angle:CGFloat, x:CGFloat, y:CGFloat, z:CGFloat) -> CATransform3D {
        var transform: CATransform3D = CATransform3DIdentity
        transform.m34 = perspective
        return CATransform3DRotate(transform, angle, x, y, z)
    }
    
    // -------------------------------------------------------------------------
    // DTIAnimProtocol
    // -------------------------------------------------------------------------
    func needLayoutSubviews() {
        self.spinnerView.frame = self.owner.bounds
        
        let contentSize = self.owner.bounds.size
        let sz = contentSize.width*3/5
        self.planeView.frame = CGRectInset(self.owner.bounds, 2.0, 2.0);
    }
    
    func needUpdateColor() {
        self.planeView.backgroundColor = self.owner.indicatorColor
    }

    func setUp() {
        self.spinnerView.addSubview(self.planeView)
        //self.spinnerView.layer.shouldRasterize = true
    }

    func startActivity() {
        self.owner.addSubview(self.spinnerView)
        
        var anim = CAKeyframeAnimation()
        anim.keyPath = "transform"
        anim.removedOnCompletion = false
        anim.repeatCount = HUGE
        anim.duration = 1.2
        anim.keyTimes = [0.0, 0.45, 0.95]
        anim.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        ]
        anim.values = [
            NSValue(CATransform3D: self.transformPlane(1.0/120.0, angle: 0.0, x: 0.0, y: 0.0, z: 0.0)),
            NSValue(CATransform3D: self.transformPlane(1.0/120.0, angle: CGFloat(M_PI), x: 0.0, y: 1.0, z: 0.0)),
            NSValue(CATransform3D: self.transformPlane(1.0/120.0, angle: CGFloat(M_PI), x: 0.0, y: 0.0, z: 1.0))
        ]
        
        self.spinnerView.layer.addAnimation(anim, forKey: "DTIAnimRotatingPlane~animateCanvas")
    }
    
    func stopActivity(animated: Bool) {
        func removeAnimations() {
            self.spinnerView.layer.removeAllAnimations()
            
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
