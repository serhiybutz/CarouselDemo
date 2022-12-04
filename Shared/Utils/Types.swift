//
//  Types.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif


#if os(macOS)

typealias ImageType = NSImage

extension Image {
    init(image: NSImage) {
        self.init(nsImage: image)
    }
}

#elseif os(iOS)

typealias ImageType = UIImage

extension Image {
    init(image: UIImage) {
        self.init(uiImage: image)
    }
}

#endif
