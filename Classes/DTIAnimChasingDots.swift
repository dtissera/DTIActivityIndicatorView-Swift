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
        // Check control size
        var f = self.owner.frame;
        if (f.size.width < 20.0) {
            f.size.width = 20.0
        }
        f.size.height = f.size.width
        self.owner.frame = f
        
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
        
        let aniBounce1 = CAKeyframeAnimation()
        aniBounce1.keyPath = "transform.scale"
        aniBounce1.values = [1, 0, 1]
        aniBounce1.removedOnCompletion = false
        aniBounce1.repeatCount = HUGE
        aniBounce1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        aniBounce1.duration = self.animationDuration
        
        var aniBounce2 = CAKeyframeAnimation()
        aniBounce2.keyPath = "transform.scale"
        aniBounce2.values = [0, 1, 0]
        aniBounce2.removedOnCompletion = false
        aniBounce2.repeatCount = HUGE
        aniBounce2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        aniBounce2.duration = self.animationDuration
        
        self.spinnerView.layer.addAnimation(aniRot, forKey: "DTIAnimChasingDots~rotateCanvas")
        self.dot1View.layer.addAnimation(aniBounce1, forKey: "DTIAnimChasingDots~scaleDot1")
        self.dot2View.layer.addAnimation(aniBounce2, forKey: "DTIAnimChasingDots~scaleDot2")
    }
    
    func stopActivity() {
        self.spinnerView.removeFromSuperview()
        
        // Remove animations
        self.spinnerView.layer.removeAllAnimations()
        self.dot1View.layer.removeAllAnimations()
        self.dot2View.layer.removeAllAnimations()
    }
}
