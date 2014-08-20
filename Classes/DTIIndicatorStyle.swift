//
//  DTIIndicatorStyle.swift
//  SampleObjc
//
//  Created by dtissera on 15/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

enum DTIIndicatorStyle {
    case rotatingPane, doubleBounce, wave, wanderingCubes, chasingDots, pulse, spotify, wp8
    
    static let defaultValue = DTIIndicatorStyle.chasingDots
    
    static func conv(value: String) -> DTIIndicatorStyle {
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

    static func convInv(value: DTIIndicatorStyle) -> String {
        switch value {
        case .rotatingPane: return "rotatingPane"
        case .doubleBounce: return "doubleBounce"
        case .wave: return "wave"
        case .wanderingCubes: return "wanderingCubes"
        case .chasingDots: return "chasingDots"
        case .pulse: return "pulse"
        case .spotify: return "spotify"
        case .wp8: return "wp8"
        default: return "?"
        }
    }
}

extension DTIIndicatorStyle {
    init() { self = .chasingDots }
}

/**
 * Allow to assign string
 */
extension DTIIndicatorStyle : StringLiteralConvertible {
    static func convertFromStringLiteral(value: String) -> DTIIndicatorStyle {
        return conv(value)
    }
    
    static func convertFromExtendedGraphemeClusterLiteral(value: String) -> DTIIndicatorStyle {
        return conv(value)
    }
}

/**
 * Allow to be constructed from String
 */
extension DTIIndicatorStyle {
    init(_ v : String) {
        self = DTIIndicatorStyle.conv(v)
    }
}