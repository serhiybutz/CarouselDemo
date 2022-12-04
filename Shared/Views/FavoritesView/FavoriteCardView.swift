//
//  FavoriteCardView.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct FavoriteCardView: View {

    let card: Card
    @Binding var isGeometryMatchPhase: Bool
    
    var body: some View {
        // We use EmptyView, because the modifier actually ignores
        // the value passed to its body() function.
        EmptyView()
            .modifier(
                FavoriteCardViewModifier(
                    card: card,
                    pct: isGeometryMatchPhase ? 0 : 1
                )
            )
    }
}

struct FavoriteCardViewModifier: AnimatableModifier {

    let card: Card
    var pct: CGFloat
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func body(content: Content) -> some View {
        let borderWidth: CGFloat = Conf.Favorites.dynamicBorderWidth(pct)
        let padding: CGFloat = Conf.Favorites.dynamicPadding(pct)

        let aspectRatio = card.imageSize.width / card.imageSize.height
        let imageTargetSize = CGSize(width: Conf.Favorites.height * aspectRatio, height: Conf.Favorites.height)

        let imageHeight = (imageTargetSize.height - Conf.Card.geo.size.height) * pct + Conf.Card.geo.size.height

        let boostPct = min(1, pct * 1.75) // boost forming final form for better impression

        let clipShape = CardViewToFavoriteShape(pct: boostPct)
        
        let shadow = (Conf.Favorites.iconShadow - Conf.Card.shadowRadius) * boostPct + Conf.Card.shadowRadius
        
        return Image(card.name)
            .resizable()
            .frame(width: imageHeight * aspectRatio, height: imageHeight)
            .clipShape(clipShape)
            .overlay(clipShape.stroke(Color.white, lineWidth: borderWidth))
            .padding(borderWidth)
            .overlay(clipShape.strokeBorder(Color.black.opacity(0.1 * pct)))
            .shadow(radius: shadow)
            .padding(padding)
    }
}
