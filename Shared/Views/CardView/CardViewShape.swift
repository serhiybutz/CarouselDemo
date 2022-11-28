//
//  CardViewShape.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct CardViewShape: InsettableShape {

    func path(in rect: CGRect) -> Path {

        let cardSize = Conf.Carousel.cardSize

        let cardRect = CGRect(
            origin: CGPoint(x: rect.midX - cardSize.width / 2,
                            y: rect.midY - cardSize.height / 2),
            size: cardSize
        )

        let rect = rect.intersection(cardRect)

        return Path(roundedRect: rect,
                    cornerSize: CGSize(width: Conf.Carousel.cardRadius,
                                       height: Conf.Carousel.cardRadius))
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        Insettable(base: self, amount: amount)
    }

    struct Insettable: InsettableShape {

        var base: CardViewShape
        var amount: CGFloat

        func path(in rect: CGRect) -> Path {

            CardViewShape()
                .path(in: rect.insetBy(dx: amount, dy: amount))
        }

        func inset(by amount: CGFloat) -> some InsettableShape {
            
            var copy = self
            copy.amount += amount
            return copy
        }
    }
}
