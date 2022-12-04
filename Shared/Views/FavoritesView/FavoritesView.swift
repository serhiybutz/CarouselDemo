//
//  FavoritesView.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct FavoritesView: View {

    @ObservedObject var vm: FavoritesViewModel

    let ns_carousel: Namespace.ID
    let ns_favorites: Namespace.ID
    @Namespace var ns_no_match

    let onCardTapped: (Card) -> Void

    var body: some View {
        HStack(alignment: .center, spacing: -60) {
            ForEach(vm.favorites.reversed()) { card in
                FavoriteCardView(card: card,
                                 isGeometryMatchPhase: Binding(get: { vm.geometryMatchPhaseCardId == card.id }, set: {_ in}))
                .matchedGeometryEffect(id: card.id,
                                       in: vm.geometryMatchPhaseCardId == card.id ? ns_carousel : ns_no_match,
                                       properties: .position,
                                       isSource: false)
                .matchedGeometryEffect(id: card.id,
                                       in: ns_favorites,
                                       isSource: true)
                .offset(vm.shouldShake ? CGSize.random(width: 10...40, height: 0...0) : .zero)
                .onAppear {
                    withWaitAnimation(.fly) {
                        // Views are matched at insertion, but onAppear we break the match
                        // in order to animate immediately after view insertion
                        vm.geometryMatchPhaseCardId = nil
                    }
                }
                .onTapGesture(count: 2) { vm.toggleFavoriteStatus(card) }
                .onTapGesture(count: 1) { onCardTapped(card) }
            }
        }
    }
}
