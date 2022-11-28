//
//  Types.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

#if os(macOS)

import AppKit
typealias ImageType = NSImage

#elseif os(iOS)

import UIKit
typealias ImageType = UIImage

#endif
