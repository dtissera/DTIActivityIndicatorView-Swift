//
//  DTIActivityIndicatorView.swift
//
//  Created by dtissera on 12/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable class DTIActivityIndicatorView: UIView {
    // warning unlike objc, we dont have TARGET_INTERFACE_BUILDER macro in swift !
    // this variable as the right value only after prepareForInterfaceBuilder()
    // is called
    // https://developer.apple.com/library/prerelease/ios/recipes/xcode_help-IB_objects_media/CreatingaLiveViewofaCustomObject.html
    // http://justabeech.com/2014/08/03/prepareforinterfacebuilder-and-property-observers/
    private var runningWithinInterfaceBuilder: Bool = false
    
    /** private properties */
    private var activityStarted: Bool = false
    
    private let animationDuration = CFTimeInterval(2)
    private let spinnerView = UIView()
    private let dot1View = UIView()
    private let dot2View = UIView()
    
    /** @IBInspectable properties */
    @IBInspectable var indicatorColor: UIColor = UIColor.whiteColor() {
        didSet {
            self.setUpColors()
        }
    }
    
    /** ctor && ~ctor */
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.setUp()
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        
        self.setUp()
    }
    
    deinit {
        if (self.activityStarted) {
            self.stopActivity()
        }
    }

    /** private members */
    private func setUp() {
        // Check control size
        var f = self.frame;
        if (f.size.width < 20.0) {
            f.size.width = 20.0
        }
        f.size.height = f.size.width
        self.frame = f

        setUpColors();
        
        self.spinnerView.addSubview(self.dot1View)
        self.spinnerView.addSubview(self.dot2View)
    }
    
    private func setUpColors() {
        // Debug stuff
        // self.spinnerView.backgroundColor = UIColor.grayColor()
        
        self.backgroundColor = UIColor.clearColor()
        self.dot1View.backgroundColor = self.indicatorColor
        self.dot2View.backgroundColor = self.indicatorColor
    }
    
    /** overrides */
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.runningWithinInterfaceBuilder = true
        
        setUpColors();
    }
    
    override func layoutSubviews() {
        self.spinnerView.frame = self.bounds
        
        let contentSize = self.bounds.size
        let sz = contentSize.width*3/5
        self.dot1View.frame = CGRect(x:(contentSize.width-sz)/2, y:1.0, width:sz, height:sz)
        self.dot2View.frame = CGRect(x:(contentSize.width-sz)/2, y:contentSize.height-sz, width:sz, height:sz)
        
        self.dot1View.layer.cornerRadius = sz/2
        self.dot2View.layer.cornerRadius = sz/2
        
        if (self.runningWithinInterfaceBuilder) {
            self.dot2View.frame = CGRect(x:(contentSize.width)/2, y:contentSize.height-3.0, width:2.0, height:2.0)
            self.dot2View.layer.cornerRadius = 0.0
        }

    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if (self.runningWithinInterfaceBuilder) {
            let context = UIGraphicsGetCurrentContext()
            CGContextSaveGState(context)
            
            CGContextSetStrokeColorWithColor(context, self.indicatorColor.CGColor)
            let dashLengths:[CGFloat] = [2.0, 2.0]
            CGContextSetLineDash(context, 0.0, dashLengths, UInt(dashLengths.count))
            CGContextStrokeRect(context, self.bounds)
            
            CGContextRestoreGState(context)
        }
    }
    
    /** public members */
    func startActivity() {
        if (self.activityStarted) {
            return
        }
        
        self.activityStarted = true
        self.addSubview(self.spinnerView)
        
        let aniRot = CABasicAnimation()
        aniRot.keyPath = "transform.rotation"
        aniRot.fromValue = 0;
        aniRot.toValue = CGFloat(2*M_PI);
        aniRot.repeatCount = HUGE
        aniRot.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        aniRot.duration = self.animationDuration

        let aniBounce1 = CAKeyframeAnimation()
        aniBounce1.keyPath = "transform.scale"
        aniBounce1.values = [1, 0, 1]
        aniBounce1.repeatCount = HUGE
        aniBounce1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        aniBounce1.duration = self.animationDuration

        var aniBounce2 = CAKeyframeAnimation()
        aniBounce2.keyPath = "transform.scale"
        aniBounce2.values = [0, 1, 0]
        aniBounce2.repeatCount = HUGE
        aniBounce2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        aniBounce2.duration = self.animationDuration

        self.spinnerView.layer.addAnimation(aniRot, forKey: "rotate-canvas")
        self.dot1View.layer.addAnimation(aniBounce1, forKey: "scale-dot-1")
        self.dot2View.layer.addAnimation(aniBounce2, forKey: "scale-dot-2")
    }

    func stopActivity() {
        if (!self.activityStarted) {
            return
        }

        self.activityStarted = false;
        self.spinnerView.removeFromSuperview()
        
        // Remove animations
        self.spinnerView.layer.removeAllAnimations()
        self.dot1View.layer.removeAllAnimations()
        self.dot2View.layer.removeAllAnimations()
    }
}
