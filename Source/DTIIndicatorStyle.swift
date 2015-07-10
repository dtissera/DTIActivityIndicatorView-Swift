//
//  DTIIndicatorStyle.swift
//  SampleObjc
//
//  Created by dtissera on 15/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import Foundation

public enum DTIIndicatorStyle: Int {
    case rotatingPane, doubleBounce, wave, wanderingCubes, chasingDots, pulse, spotify, wp8
    
    public static let defaultValue = DTIIndicatorStyle.chasingDots
    
    public static func conv(value: String) -> DTIIndicatorStyle {
        switch value {
            case "rotatingPane": return .rotatingPane
            case "doubleBounce": return .doubleBounce
            case "wave": return .wave
            case "wanderingCubes": return .wanderingCubes
            case "chasingDots": return .chasingDots
            case "pulse": return .pulse
            case "spotify": return .spotify
            case "wp8": return .wp8
            default: return defaultValue
        }
    }
    
    public static func convInv(value: DTIIndicatorStyle) -> String {
        switch value {
            case .rotatingPane: return "rotatingPane"
            case .doubleBounce: return "doubleBounce"
            case .wave: return "wave"
            case .wanderingCubes: return "wanderingCubes"
            case .chasingDots: return "chasingDots"
            case .pulse: return "pulse"
            case .spotify: return "spotify"
            case .wp8: return "wp8"
        }
    }
}

extension DTIIndicatorStyle {
    init() { self = .chasingDots }
    
    static func random() -> DTIIndicatorStyle {
        return DTIIndicatorStyle(rawValue: Int(arc4random_uniform(7)) + 1)!
    }
    
}

/**
* Allow to be constructed from string / assign string
*/
extension DTIIndicatorStyle : StringLiteralConvertible {
    
    public init(stringLiteral v : String) {
        self = DTIIndicatorStyle.conv(v)
    }
    
    public init(unicodeScalarLiteral v : String) {
        self = DTIIndicatorStyle.conv(v)
    }
    
    public init(extendedGraphemeClusterLiteral v: String) {
        self = DTIIndicatorStyle.conv(v)
    }
    
    static func convertFromStringLiteral(value: String) -> DTIIndicatorStyle {
        return conv(value)
    }
    
    static func convertFromExtendedGraphemeClusterLiteral(value: String) -> DTIIndicatorStyle {
        return conv(value)
    }
}

