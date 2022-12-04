//
//  ModalViewModel.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import CoreGraphics
import Foundation

enum ModalTransitionSource: Equatable { case carousel, favorites }

@MainActor
final class ModalViewModel: ObservableObject {

    let card: Card
    let transitionSource: ModalTransitionSource

    init(card: Card, transitionSource: ModalTransitionSource) {
        self.card = card
        self.transitionSource = transitionSource
    }
}
