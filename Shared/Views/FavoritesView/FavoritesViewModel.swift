//
//  FavoritesViewModel.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

@MainActor
final class FavoritesViewModel: ObservableObject {

    @Published var favorites: [Card] = []
    @Published var geometryMatchPhaseCardId: UUID?
    @Published var shouldShake = false

    func isFavorite(_ item: Card) -> Bool {
        favorites.contains { $0.id == item.id }
    }

    func toggleFavoriteStatus(_ item: Card) {
        if let idx = favorites.firstIndex(where: { $0.id == item.id }) {
            withWaitAnimation {
                _ = favorites.remove(at: idx)
            }
        } else {
            geometryMatchPhaseCardId = item.id
            favorites.append(item)
            animateShaking()
        }
    }

    func animateShaking() {
        Task {
            try await Task.sleep(seconds: 0.1)
            withWaitAnimation(.shake) {
                shouldShake = true
            }

            Task {
                try await Task.sleep(seconds: 0.1)
                withWaitAnimation(.shake) {
                    shouldShake = false
                }
            }
        }
    }
}
