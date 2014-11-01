//
//  DTIAnimDoubleBounce.swift
//  SampleObjc
//
//  Created by dtissera on 15/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit
import QuartzCore

class DTIAnimDoubleBounce: DTIAnimProtocol {
    /** private properties */
    private let owner: DTIActivityIndicatorView
    
    private let spinnerView = UIView()
    private let doubleBounce1View = UIView()
    private let doubleBounce2View = UIView()
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
        let doubleBounceSize = CGRectInset(self.owner.bounds, 2.0, 2.0).size

        self.doubleBounce1View.frame = CGRectMake(0.0, 0.0, doubleBounceSize.width, doubleBounceSize.height)
        self.doubleBounce2View.frame = CGRectMake(0.0, 0.0, doubleBounceSize.width, doubleBounceSize.height)
        
        let sz = doubleBounceSize.width
        
        self.doubleBounce1View.layer.cornerRadius = sz/2
        self.doubleBounce2View.layer.cornerRadius = sz/2
    }

    func needUpdateColor() {
        // Debug stuff
        // self.spinnerView.backgroundColor = UIColor.grayColor()
        
        self.doubleBounce1View.backgroundColor = self.owner.indicatorColor
        self.doubleBounce2View.backgroundColor = self.owner.indicatorColor
    }
    

    func setUp() {
        self.spinnerView.addSubview(self.doubleBounce1View)
        self.spinnerView.addSubview(self.doubleBounce2View)
        
        self.doubleBounce1View.layer.opacity = 0.6;
        self.doubleBounce2View.layer.opacity = 0.6;
    }

    func startActivity() {
        self.owner.addSubview(self.spinnerView)
        
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
        
        self.doubleBounce1View.layer.addAnimation(aniScale1, forKey: "DTIAnimDoubleBounce~aniScale1")
        self.doubleBounce2View.layer.addAnimation(aniScale2, forKey: "DTIAnimDoubleBounce~aniScale2")
    }
    
    func stopActivity(animated: Bool) {
        func removeAnimations() {
            self.spinnerView.layer.removeAllAnimations()
            self.doubleBounce1View.layer.removeAllAnimations()
            self.doubleBounce1View.layer.removeAllAnimations()
            
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
