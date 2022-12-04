//
//  Conf.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

import CoreGraphics
import Foundation

enum Conf {
    enum Screen {
#if os(macOS)
        static let size: CGSize = CGSize(
            width: NSScreen.main!.visibleFrame.size.width / NSScreen.main!.backingScaleFactor,
            height: NSScreen.main!.visibleFrame.size.height / NSScreen.main!.backingScaleFactor)
#elseif os(iOS)
        static let size: CGSize = CGSize(
            width: UIScreen.main.currentMode!.size.width / UIScreen.main.scale,
            height: UIScreen.main.currentMode!.size.height / UIScreen.main.scale)
#endif
        static let dimension = min(size.width, size.height)
    }

    enum Card {
        static let geo: ShapeGeo = ShapeGeo(
            size: {
#if os(iOS)
                CGSize(width: 250, height: 360)
#elseif os(macOS)
                CGSize(width: 250, height: 360)
#endif
            }(),
            roundedCornerRadius: 20
        )
        static let shadowRadius: CGFloat = 8
    }

    enum Favorites {
        static let height: CGFloat = Screen.dimension * 0.175 // width = height
        static let borderWidth: CGFloat = 2

        static let dynamicBorderWidth = { (pct: CGFloat) -> CGFloat in
            borderWidth * pct
        }
        static let dynamicPadding = { (pct: CGFloat) -> CGFloat in
            2 * dynamicBorderWidth(pct)
        }

        static let iconShadow: CGFloat = 3
    }

    enum Modal {
        static func width(for windowWidth: CGFloat) -> CGFloat {
            min(700, windowWidth * 0.9)
        }
        static let topOffset: CGFloat = 50
        static let bottomOffset: CGFloat = 50
        static let roundedCornerRadius: CGFloat = 20
        static let padding: CGFloat = 20
    }

    // cutting off the spring resting part of the animation
    static func cutOffSpringResting(_ pct: CGFloat) -> CGFloat {
        min(1, pct * 1.05)
    }

    static let sampleText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut mauris ipsum, ultrices nec aliquam a, bibendum in sem.\n\nPraesent ac neque sed risus auctor consectetur. Curabitur dui ex, suscipit ut sapien at, fermentum ultricies nisi. Praesent nec dignissim arcu. Praesent euismod lectus nec nunc vehicula, et ultrices metus volutpat.\n\nNunc libero odio, fringilla at rutrum id, maximus vitae urna. Nulla lobortis erat a ullamcorper rhoncus. Aliquam a ante mattis, mollis libero eget, lacinia nulla.\n\nMorbi eu lacus mauris. Sed arcu erat, porttitor sed massa quis, varius aliquet lorem. Proin at lobortis purus. Nam libero enim, rutrum laoreet malesuada eu, vulputate sit amet odio. Aliquam ut ultrices dolor. Aenean sed mi quis augue egestas scelerisque. Nulla vel diam fringilla, tempor ex ut, elementum sapien. Vestibulum laoreet augue ut nisl porta posuere.\n\nFusce scelerisque massa sit amet ante ultricies, sit amet accumsan nibh sodales. Maecenas ac ligula urna. Maecenas sollicitudin elit elementum, hendrerit velit sit amet, commodo nulla. Phasellus semper rutrum erat sed feugiat. Integer vel purus a velit semper ullamcorper ut vitae quam. Quisque nec odio eu lacus eleifend tincidunt eu nec velit. Donec scelerisque facilisis purus, at eleifend mi hendrerit id. Nullam consequat commodo quam, eu auctor lectus suscipit sed. Etiam efficitur, augue vel imperdiet mollis, augue ante efficitur mi, ac porttitor lorem elit eget sapien.\n\nCras sit amet augue quis nulla facilisis placerat ut at eros. Duis a suscipit justo. Suspendisse potenti. Cras mattis, erat nec sodales blandit, sem ex faucibus mi, sit amet tempor massa justo eu dolor."
}
