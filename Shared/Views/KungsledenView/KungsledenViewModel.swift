//
//  KungsledenViewModel.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI
import Carousel

@MainActor
final class KungsledenViewModel: ObservableObject {

    let photoRepo = PhotoRepository()
    var namespace: Namespace.ID!

    var onDblClick: ((Card) -> Void)?

    @Published var blur: Bool = false

    @Published var modalVM: ModalViewModel?

    func openModal(_ card: Card, transitionSource: ModalTransitionSource) {

        self.modalVM = ModalViewModel(
            card: card,
            transitionSource: transitionSource
        )

        Task {
            withWaitAnimation {
                blur = true
            }
        }
    }

    func dismissModal() {
        withWaitAnimation {
            self.modalVM = nil
            blur = false
        }
    }
}

extension KungsledenViewModel: CarouselDataSource {

    var carouselItemCount: Int { photoRepo.cards.count }

    func carouselItemView(for idx: Int) -> CardView {

        CardView(
            card: photoRepo.cards[idx],
            namespace: namespace
        )
    }
}

extension KungsledenViewModel: CarouselDelegate {
    func carouselActiveChanged(newIdx: Int) {}
    func carouselActiveClicked(idx: Int) {
        openModal(photoRepo.cards[idx], transitionSource: .carousel)
    }
    func carouselActiveDoubleClicked(idx: Int) {
        onDblClick?(photoRepo.cards[idx])
    }
}
