//
//  PhotoRepository.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

final class PhotoRepository {

    var cards: [Card] = []

    init() {
        load()
    }

    func load() {
        (0...22).forEach {
            let name = String(format: "%02d", $0)
            if let image = ImageType(named: name) {
                addCard(fname: name, image: image)
            }
        }
    }

    func addCard(fname: String, image: ImageType) {
        let zoomCoeff: CGFloat = 3
        let resizedImage = image.resizedImage(scale: Conf.Card.geo.size.width / image.size.width * zoomCoeff)!
        cards.append(Card(
            name: fname,
            description: Conf.sampleText,
            image: resizedImage))
    }
}
