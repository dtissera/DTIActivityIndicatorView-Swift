//
//  DTIAnimPulse.swift
//  SampleObjc
//
//  Created by dtissera on 15/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit
import QuartzCore

class DTIAnimPulse: DTIAnimProtocol {
    /** private properties */
    private let owner: DTIActivityIndicatorView
    
    private let spinnerView = UIView()
    private let pulseView = UIView()
    private let animationDuration = CFTimeInterval(1)
    
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
        let pulseViewSize = CGRectInset(self.owner.bounds, 2.0, 2.0).size
        
        self.pulseView.frame = CGRectMake(0.0, 0.0, pulseViewSize.width, pulseViewSize.height)
        
        let sz = pulseViewSize.width
        
        self.pulseView.layer.cornerRadius = sz/2
    }
    
    func needUpdateColor() {
        // Debug stuff
        // self.spinnerView.backgroundColor = UIColor.grayColor()
        
        self.pulseView.backgroundColor = self.owner.indicatorColor
    }
    
    
    func setUp() {
        self.spinnerView.addSubview(self.pulseView)
    }
    
    func startActivity() {
        self.owner.addSubview(self.spinnerView)
        
        let aniScale = CAKeyframeAnimation()
        aniScale.keyPath = "transform.scale"
        aniScale.values = [0, 1]
        
        let aniOpacity = CAKeyframeAnimation()
        aniOpacity.keyPath = "opacity"
        aniOpacity.values = [1.0, 0.0]

        let aniPulseGroup = CAAnimationGroup();
        aniPulseGroup.removedOnCompletion = false
        aniPulseGroup.repeatCount = HUGE
        aniPulseGroup.duration = self.animationDuration;
        aniPulseGroup.animations = [aniScale, aniOpacity];
        aniPulseGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        
        self.pulseView.layer.addAnimation(aniPulseGroup, forKey: "DTIAnimPulse~pulse")
    }
    
    func stopActivity(animated: Bool) {
        func removeAnimations() {
            self.spinnerView.layer.removeAllAnimations()
            self.pulseView.layer.removeAllAnimations()
            
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