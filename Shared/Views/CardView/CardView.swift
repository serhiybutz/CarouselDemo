//
//  CardView.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct CardView: View {

    let card: Card

    let namespace: Namespace.ID
    let shape = RoundedRectangle(cornerRadius: Conf.Card.geo.roundedCornerRadius)

    var body: some View {
        Color.clear.overlay(
            Image(image: card.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .overlay(CardTitleView(item: card), alignment: .topLeading)
        .clipShape(shape)
        .contentShape(shape)
        .matchedGeometryEffect(id: card.id, in: namespace, isSource: true)
        .shadow(radius: Conf.Card.shadowRadius)
        .frame(width: Conf.Card.geo.size.width, height: Conf.Card.geo.size.height)
    }
}

