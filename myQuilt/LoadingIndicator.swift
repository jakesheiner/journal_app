//
//  LoadingBuilder.swift
//  SwiftfulLoadingIndicators
//
//  Created by Nick Sarno on 1/12/21.
//

import SwiftUI

public struct LoadingIndicator: View {
    
    let animation: LoadingAnimation
    let size: CGFloat
    let speed: Double
    let color: Color
    
    public init(
        animation: LoadingAnimation = .threeBalls,
        color: Color = .primary,
        size: Size = .medium,
        speed: Speed = .normal) {
            self.animation = animation
            self.size = size.rawValue
            self.speed = speed.rawValue
            self.color = color
    }
    
    public var body: some View {
        switch animation {
        case .threeBalls: LoadingThreeBalls(color: color, size: size, speed: speed)
       
        case .threeBallsBouncing: LoadingThreeBallsBouncing(color: color, size: size, speed: speed)
        
        }
    }
    
    public enum LoadingAnimation: String, CaseIterable {
        case threeBalls
      
        case threeBallsBouncing
        
    }
    
    public enum Speed: Double, CaseIterable {
        case slow = 1.0
        case normal = 0.5
        case fast = 0.25
        
        var stringRepresentation: String {
            switch self {
            case .slow: return ".slow"
            case .normal: return ".normal"
            case .fast: return ".fast"
            }
        }
    }

    public enum Size: CGFloat, CaseIterable {
        case small = 25
        case medium = 50
        case large = 100
        case extraLarge = 150
        
        var stringRepresentation: String {
            switch self {
            case .small: return ".small"
            case .medium: return ".medium"
            case .large: return ".large"
            case .extraLarge: return ".extraLarge"
            }
        }
    }
}
