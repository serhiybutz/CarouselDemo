//
//  FavoritesModalTransitionParams.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct FavoritesModalTransitionParams: ModalTransitionParams {

    let card: Card
    let pct: CGFloat
    let windowSize: CGSize

    let aspectRatio: CGFloat

    private var imageTargetSize: CGSize {
        CGSize(width: Conf.Modal.width(for: windowSize.width), height: Conf.Modal.width(for: windowSize.width) / aspectRatio)
    }

    init(card: Card, pct: CGFloat, windowSize: CGSize) {
        self.card = card
        self.pct = pct
        self.windowSize = windowSize

        self.aspectRatio = card.imageSize.width / card.imageSize.height
    }

    var imageHeight: CGFloat {
        (imageTargetSize.height - Conf.Favorites.height) * Conf.cutOffSpringResting(pct) + Conf.Favorites.height
    }
    var imageWidth: CGFloat {
        (imageTargetSize.width - Conf.Favorites.height) * Conf.cutOffSpringResting(pct) + Conf.Favorites.height
    }

    var clipCornerRadius: CGFloat {
        (Conf.Modal.roundedCornerRadius - favCornerRadius) * pct + favCornerRadius
    }
    private let favCornerRadius: CGFloat = Conf.Favorites.height / 2

    var innerClipShape: AnyShape { AnyShape(RoundedRectangleShape(cornerRadius: clipCornerRadius)) }

    func outerClipShape(_ isTransitionComplete: Bool) -> AnyShape {
        isTransitionComplete
            ? AnyShape(IdentityShape())
            : AnyShape(FavoritesToModalClipShape(pct: Conf.cutOffSpringResting(pct)))
    }

    // Since we are matching only _position_ of source and destination transintion views,
    // and the origin point is in the center of views, we need to match them in the very
    // beginning
    func verticalOffset(with proxy: GeometryProxy) -> CGFloat {
        (proxy.size.height / 2 - Conf.Favorites.height / 2) * (1 - pct)
    }

    var verticalTargetOffset: CGFloat { Conf.Modal.topOffset * pct }
}

