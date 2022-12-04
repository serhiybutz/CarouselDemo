//
//  CarouselModalTransitionParams.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct CarouselModalTransitionParams: ModalTransitionParams {

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
        (imageTargetSize.height - Conf.Card.geo.size.height) * imageHeightPct + Conf.Card.geo.size.height
    }
    var imageWidth: CGFloat {
        imageHeight * aspectRatio
    }

    private var imageHeightPct: CGFloat {
        Conf.cutOffSpringResting(pct)
    }

    var clipCornerRadius: CGFloat {
        (Conf.Modal.roundedCornerRadius - Conf.Card.geo.roundedCornerRadius) * Conf.cutOffSpringResting(pct) + Conf.Card.geo.roundedCornerRadius
    }

    var innerClipShape: AnyShape { AnyShape(RoundedRectangleShape(cornerRadius: clipCornerRadius)) }

    func outerClipShape(_ isTransitionComplete: Bool) -> AnyShape {
        isTransitionComplete
            ? AnyShape(IdentityShape())
            : AnyShape(CarouselToModalClipShape(
                geo: ShapeGeo(
                    size: Conf.Card.geo.size,
                    roundedCornerRadius: clipCornerRadius),
                pct: outerClipPct))
    }

    private var outerClipPct: CGFloat { Conf.cutOffSpringResting(pct) }

    // Since we are matching only _position_ of source and destination transintion views,
    // and the origin point is in the center of views, we need to match them in the very
    // beginning
    func verticalOffset(with proxy: GeometryProxy) -> CGFloat {
        (proxy.size.height - Conf.Card.geo.size.height) / 2 * (1 - Conf.cutOffSpringResting(pct))
    }

    var verticalTargetOffset: CGFloat { Conf.Modal.topOffset * Conf.cutOffSpringResting(pct) }
}
