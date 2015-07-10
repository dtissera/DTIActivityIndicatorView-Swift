//
//  DTIActivityIndicatorView.swift
//
//  Created by dtissera on 12/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit
import QuartzCore
import Foundation

@IBDesignable
@objc
public class DTIActivityIndicatorView: UIView {
    // warning unlike objc, we dont have TARGET_INTERFACE_BUILDER macro in swift !
    // this variable as the right value only after prepareForInterfaceBuilder()
    // is called
    // https://developer.apple.com/library/prerelease/ios/recipes/xcode_help-IB_objects_media/CreatingaLiveViewofaCustomObject.html
    // http://justabeech.com/2014/08/03/prepareforinterfacebuilder-and-property-observers/
    private var runningWithinInterfaceBuilder: Bool = false
    
    /** private properties */
    private var activityStarted: Bool = false
    
    private var currentAnimation: DTIAnimProtocol? = nil
    
    /** @IBInspectable properties */
    @IBInspectable public var indicatorColor: UIColor = UIColor.whiteColor() {
        didSet {
            if (self.currentAnimation != nil) {
                self.currentAnimation!.needUpdateColor()
            }
        }
    }
    
    @IBInspectable public var indicatorStyle: String = DTIIndicatorStyle.convInv(.defaultValue)
    
    /** ctor && ~ctor */
    override public init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        if (self.activityStarted) {
            self.stopActivity(false)
        }
    }
    
    /** private members */
    private func setUpAnimation() {
        let style = DTIIndicatorStyle.conv(self.indicatorStyle)
        
        switch style {
        case .rotatingPane:self.currentAnimation = DTIAnimRotatingPlane(indicatorView: self)
        case .doubleBounce:self.currentAnimation = DTIAnimDoubleBounce(indicatorView: self)
        case .wave:self.currentAnimation = DTIAnimWave(indicatorView: self)
        case .wanderingCubes:self.currentAnimation = DTIAnimWanderingCubes(indicatorView: self)
        case .chasingDots:self.currentAnimation = DTIAnimChasingDots(indicatorView: self)
        case .pulse:self.currentAnimation = DTIAnimPulse(indicatorView: self)
        case .spotify:self.currentAnimation = DTIAnimSpotify(indicatorView: self)
        case .wp8:self.currentAnimation = DTIAnimWp8(indicatorView: self)
        }
        
        self.setUpColors()
    }
    
    private func setUpColors() {
        self.backgroundColor = UIColor.clearColor()
        
        if (self.currentAnimation != nil) {
            self.currentAnimation!.needUpdateColor()
        }
    }
    
    /** overrides */
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.runningWithinInterfaceBuilder = true
        
        setUpColors();
    }
    
    override public func layoutSubviews() {
        if (self.currentAnimation != nil) {
            currentAnimation!.needLayoutSubviews()
        }
    }

    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if (self.runningWithinInterfaceBuilder) {
            let context = UIGraphicsGetCurrentContext()
            CGContextSaveGState(context)
            
            var arrayOfDashLength: [CGFloat] = [2.0, 2.0]
            CGContextSetStrokeColorWithColor(context, self.indicatorColor.CGColor)
            let dash = { (phase: CGFloat, lengths: UnsafePointer<CGFloat>, count: Int) -> Void in
                CGContextSetLineDash(context, phase, lengths, count)
            }
            dash(0.0, arrayOfDashLength, arrayOfDashLength.count)
            
            CGContextStrokeRect(context, self.bounds)
            
            CGContextRestoreGState(context)
        }
    }
    
    override public func sizeThatFits(size: CGSize) -> CGSize {
        if (size.width < 20.0) {
            return CGSize(width: 20.0, height: 20.0)
        }
        // force width = height
        return CGSize(width: size.width, height: size.width)
    }
    
    /** public members */
    public func startActivity() {
        if (self.activityStarted) {
            return
        }
        
        self.activityStarted = true
        self.setUpAnimation()
        
        currentAnimation!.needLayoutSubviews()
        currentAnimation!.setUp()
        currentAnimation!.startActivity()
    }

    public func stopActivity(animated: Bool) {
        if (!self.activityStarted) {
            return
        }
        
        self.activityStarted = false;
        currentAnimation!.stopActivity(animated)
    }

    public func stopActivity() {
        self.stopActivity(true)
    }
    

}
