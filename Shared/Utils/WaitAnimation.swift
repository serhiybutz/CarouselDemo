//
//  WaitAnimation.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

var debugAnimations = false
let DebugAnimationDuration: CGFloat = 6.0

struct WaitAnimation {
    let animation: Animation
    let duration: TimeInterval
}

extension WaitAnimation {

    static var `default`: WaitAnimation {
        if debugAnimations {
            return WaitAnimation(
                animation: Animation.easeInOut(duration: DebugAnimationDuration),
                duration: DebugAnimationDuration)
        } else {
            return WaitAnimation(
                animation: Animation.default,
                duration: 0.35)
        }
    }

    static var shake: WaitAnimation {
        if debugAnimations {
            return WaitAnimation(
                animation: Animation.easeInOut(duration: DebugAnimationDuration),
                duration: DebugAnimationDuration)
        } else {
            return WaitAnimation(
                animation: Animation.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25),
                duration: 0.6 + 0.25)
        }
    }

    static var fly: WaitAnimation {
        if debugAnimations {
            return WaitAnimation(
                animation: Animation.easeInOut(duration: DebugAnimationDuration),
                duration: DebugAnimationDuration)
        } else {
            return WaitAnimation(
                animation: Animation.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25),
                duration: 0.6 + 0.25)
        }
    }
}

@discardableResult
func withWaitAnimation<Result>(_ animation: WaitAnimation = .default, execute: () throws -> Result, complete: (() -> Void)? = nil) rethrows -> Result {

    let result = try SwiftUI.withAnimation(animation.animation, execute)
    if let complete = complete {
        DispatchQueue.main.asyncAfter(deadline: .now() + animation.duration) {
            complete()
        }
    }
    return result
}
