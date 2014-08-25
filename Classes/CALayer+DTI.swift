//
//  CALayer+DTI.swift
//  SampleObjc
//
//  Created by dtissera on 16/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit
import QuartzCore

extension CALayer {
    func dismissAnimated(completionBlock: () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock { () -> Void in
            completionBlock()
        }
        let aniScale = CABasicAnimation()
        aniScale.keyPath = "transform.scale"
        aniScale.toValue = 0.0;
        
        let aniFade = CABasicAnimation()
        aniFade.keyPath = "opacity"
        aniFade.toValue = 0.0
        
        let aniGroup = CAAnimationGroup();
        aniGroup.removedOnCompletion = false
        aniGroup.animations = [aniScale, aniFade];
        aniGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        aniGroup.duration = CFTimeInterval(0.25)
        aniGroup.fillMode = kCAFillModeForwards
        
        self.addAnimation(aniGroup, forKey: nil)
        CATransaction.commit()
    }
}