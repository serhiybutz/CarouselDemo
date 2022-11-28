//
//  CardView.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct CardView: View {

    @ObservedObject var vm: CardViewModel

    var body: some View {

        Color.clear.overlay(
            Image("\(vm.card.name)")
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .overlay(CardTitleView(item: vm.card), alignment: .topLeading)
        .clipShape(CardViewShape())
        .contentShape(CardViewShape())
        .shadow(radius: Conf.Carousel.cardShadow)
    }
}

