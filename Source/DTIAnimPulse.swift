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
        
        _ = self.owner.bounds.size
        let pulseViewSize = self.owner.bounds.insetBy(dx: 2.0, dy: 2.0).size
        self.pulseView.frame = CGRect(x: 0.0, y: 0.0, width: pulseViewSize.width, height: pulseViewSize.height)
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
        aniPulseGroup.isRemovedOnCompletion = false
        aniPulseGroup.repeatCount = HUGE
        aniPulseGroup.duration = self.animationDuration;
        aniPulseGroup.animations = [aniScale, aniOpacity];
        aniPulseGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        
        self.pulseView.layer.add(aniPulseGroup, forKey: "DTIAnimPulse~pulse")
    }
    
    func stopActivity(animated: Bool) {
        func removeAnimations() {
            self.spinnerView.layer.removeAllAnimations()
            self.pulseView.layer.removeAllAnimations()
            
            self.spinnerView.removeFromSuperview()
        }
        
        if (animated) {
            self.spinnerView.layer.dismissAnimated {
                removeAnimations()
            }
        }
        else {
            removeAnimations()
        }
    }
}
