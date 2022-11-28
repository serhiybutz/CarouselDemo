//
//  CardViewModel.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

final class CardViewModel: ObservableObject {

    let card: Card

    init(card: Card) {

        self.card = card
    }
}
