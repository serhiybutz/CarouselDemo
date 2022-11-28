//
//  KungsledenViewModel.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import Carousel
import SwiftUI

final class KungsledenViewModel: ObservableObject {

    let photoRepo = PhotoRepository()

}

extension KungsledenViewModel: CarouselDataSource {

    var carouselItemCount: Int { photoRepo.cards.count }

    func carouselItemView(for idx: Int) -> CardView {

        CardView(
            vm: CardViewModel(card: photoRepo.cards[idx])
        )
    }
}

extension KungsledenViewModel: CarouselDelegate {
    func carouselActiveChanged(newIdx: Int) {}
    func carouselActiveClicked(idx: Int) {}
    func carouselActiveDoubleClicked(idx: Int) {}
}
