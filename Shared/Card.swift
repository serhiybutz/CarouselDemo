//
//  Card.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

struct Card: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let image: ImageType
    var imageSize: CGSize {
        image.size
    }
}
