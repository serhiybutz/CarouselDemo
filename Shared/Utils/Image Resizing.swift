//
//  Image Resizing.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import Accelerate
import CoreImage

#if os(macOS)

import AppKit

extension NSImage {

    static let sharedResizeImageContext = CIContext(options: [.useSoftwareRenderer: false])

    func resizedImage(scale: CGFloat, aspectRatio: CGFloat? = 1.0) -> NSImage? {

        var imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        guard let cgImage = cgImage(forProposedRect: &imageRect, context: nil, hints: nil) else {
            return nil
        }

        let image = CIImage(cgImage: cgImage)

        let filter = CIFilter(name: "CILanczosScaleTransform")
        filter?.setValue(image, forKey: kCIInputImageKey)
        filter?.setValue(scale, forKey: kCIInputScaleKey)
        filter?.setValue(aspectRatio, forKey: kCIInputAspectRatioKey)

        guard let outputCIImage = filter?.outputImage,
              let outputCGImage = NSImage.sharedResizeImageContext.createCGImage(
                outputCIImage,
                from: outputCIImage.extent)
        else {
            return nil
        }

        return NSImage(cgImage: outputCGImage, size: CGSize(width: outputCGImage.width, height: outputCGImage.height))
    }
}

#elseif os(iOS)

import UIKit

extension UIImage {

    static let sharedResizeImageContext = CIContext(options: [.useSoftwareRenderer: false])

    func resizedImage(scale: CGFloat, aspectRatio: CGFloat? = 1.0) -> UIImage? {

        guard let cgImage = self.cgImage else {
            return nil
        }

        let image = CIImage(cgImage: cgImage)

        let filter = CIFilter(name: "CILanczosScaleTransform")
        filter?.setValue(image, forKey: kCIInputImageKey)
        filter?.setValue(scale, forKey: kCIInputScaleKey)
        filter?.setValue(aspectRatio, forKey: kCIInputAspectRatioKey)

        guard let outputCIImage = filter?.outputImage,
              let outputCGImage = UIImage.sharedResizeImageContext.createCGImage(
                outputCIImage,
                from: outputCIImage.extent)
        else {
            return nil
        }

        return UIImage(cgImage: outputCGImage)
    }
}

#endif
