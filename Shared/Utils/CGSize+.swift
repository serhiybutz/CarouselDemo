//
//  CGSize+.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import CoreGraphics

extension CGSize {

    static func random(width: ClosedRange<CGFloat>, height: ClosedRange<CGFloat>) -> CGSize {
        CGSize(width: CGFloat.random(in: width), height: CGFloat.random(in: height))
    }

    static func random(in range: ClosedRange<CGFloat>) -> CGSize {
        CGSize(width: CGFloat.random(in: range), height: CGFloat.random(in: range))
    }
}

extension CGSize {

    func clamped(to maxSize: CGSize) -> CGSize {
        CGSize(width: min(width, maxSize.width),
               height: min(height, maxSize.height))
    }
}

extension CGSize {

    func aspectFit(into size: CGSize) -> CGSize {

        if self.width == 0.0 || self.height == 0.0 {
            return self
        }

        let widthRatio = size.width / self.width
        let heightRatio = size.height / self.height
        let aspectFitRatio = min(widthRatio, heightRatio)
        return CGSize(width: self.width * aspectFitRatio, height: self.height * aspectFitRatio)
    }

    func aspectFill(into size: CGSize) -> CGSize {
        if self.width == 0.0 || self.height == 0.0 {
            return self
        }

        let widthRatio = size.width / self.width
        let heightRatio = size.height / self.height
        let aspectFillRatio = max(widthRatio, heightRatio)
        return CGSize(width: self.width * aspectFillRatio, height: self.height * aspectFillRatio)
    }
}

extension CGSize {
    func modified(handler: (Self) -> Self) -> Self {
        handler(self)
    }
}
