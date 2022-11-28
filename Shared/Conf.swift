//
//  Conf.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import CoreGraphics
import Foundation

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

enum Conf {

    enum Carousel {

        static let cardSize = CGSize(width: 250, height: 360)
        static let cardRadiusPct: CGFloat = 0.02
        static var cardRadius: CGFloat { Conf.Screen.dimension * cardRadiusPct }
        static let cardShadow: CGFloat = 8
    }

    enum Screen {
#if os(macOS)
        static let dimension = min(NSScreen.main!.frame.width, NSScreen.main!.frame.height)
#elseif os(iOS)
        static let dimension = min(UIScreen.main.currentMode!.size.width, UIScreen.main.currentMode!.size.height)
#endif
    }
}
