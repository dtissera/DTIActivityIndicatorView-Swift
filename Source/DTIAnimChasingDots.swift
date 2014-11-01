//
//  DTIAnimChasingDots.swift
//  SampleApplication
//
//  Created by dtissera on 15/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit
import QuartzCore

class DTIAnimChasingDots: DTIAnimProtocol {
    /** private properties */
    private let owner: DTIActivityIndicatorView
    
    private let spinnerView = UIView()
    private let dot1View = UIView()
    private let dot2View = UIView()
    private let animationDuration = CFTimeInterval(2)

    /** ctor */
    init(indicatorView: DTIActivityIndicatorView) {
        self.owner = indicatorView
    }
    
    // -------------------------------------------------------------------------
    // DTIAnimProtocol
    // -------------------------------------------------------------------------
    func needLayoutSubviews() {
        self.spinnerView.frame = self.owner.bounds
        
        let contentSize = self.owner.bounds.size
        let sz = contentSize.width*3/5
        self.dot1View.frame = CGRect(x:(contentSize.width-sz)/2, y:1.0, width:sz, height:sz)
        self.dot2View.frame = CGRect(x:(contentSize.width-sz)/2, y:contentSize.height-sz, width:sz, height:sz)
        
        self.dot1View.layer.cornerRadius = sz/2
        self.dot2View.layer.cornerRadius = sz/2
        
        /*
        if (self.runningWithinInterfaceBuilder) {
            self.dot2View.frame = CGRect(x:(contentSize.width)/2, y:contentSize.height-3.0, width:2.0, height:2.0)
            self.dot2View.layer.cornerRadius = 0.0
        }*/

    }
    
    func needUpdateColor() {
        // Debug stuff
        // self.spinnerView.backgroundColor = UIColor.grayColor()
        
        self.dot1View.backgroundColor = self.owner.indicatorColor
        self.dot2View.backgroundColor = self.owner.indicatorColor
    }
    
    func setUp() {
        self.spinnerView.addSubview(self.dot1View)
        self.spinnerView.addSubview(self.dot2View)
        
        self.spinnerView.layer.shouldRasterize = true
    }
    
    func startActivity() {
        self.owner.addSubview(self.spinnerView)
        
        let aniRot = CABasicAnimation()
        aniRot.keyPath = "transform.rotation"
        aniRot.fromValue = 0;
        aniRot.toValue = CGFloat(2*M_PI);
        aniRot.removedOnCompletion = false
        aniRot.repeatCount = HUGE
        aniRot.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        aniRot.duration = self.animationDuration
        
        let aniScale1 = CAKeyframeAnimation()
        aniScale1.keyPath = "transform.scale"
        aniScale1.values = [1, 0, 1]
        aniScale1.removedOnCompletion = false
        aniScale1.repeatCount = HUGE
        aniScale1.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        ]
        aniScale1.duration = self.animationDuration
        
        var aniScale2 = CAKeyframeAnimation()
        aniScale2.keyPath = "transform.scale"
        aniScale2.values = [0, 1, 0]
        aniScale2.removedOnCompletion = false
        aniScale2.repeatCount = HUGE
        aniScale2.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        ]
        aniScale2.duration = self.animationDuration
        
        self.spinnerView.layer.addAnimation(aniRot, forKey: "DTIAnimChasingDots~aniRot")
        self.dot1View.layer.addAnimation(aniScale1, forKey: "DTIAnimChasingDots~aniScale1")
        self.dot2View.layer.addAnimation(aniScale2, forKey: "DTIAnimChasingDots~aniScale2")
    }
    
    func stopActivity(animated: Bool) {
        func removeAnimations() {
            self.spinnerView.layer.removeAllAnimations()
            self.dot1View.layer.removeAllAnimations()
            self.dot2View.layer.removeAllAnimations()
            
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
