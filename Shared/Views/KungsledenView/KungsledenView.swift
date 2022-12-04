//
//  KungsledenView.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import Carousel
import SwiftUI

struct KungsledenView: View {

    @Environment(\.windowSize) var windowSize

    @Namespace var ns_carousel // ids to match carousel elements with modal
    @Namespace var ns_favorites // ids to match favorite icons with modal

    @StateObject var vm = KungsledenViewModel()
    @StateObject var favoritesVM = FavoritesViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(alignment: .leading) {
                    //-------------------------------------------------------
                    // Main View: Title + Favorites + Grid (zIndex = 1)
                    //-------------------------------------------------------
                    // Header (Title + Favorites)
                    TitleView()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 100)
                        .overlay(
                            // Title View (top left)
                            FavoritesView(
                                vm: favoritesVM,
                                ns_carousel: ns_carousel,
                                ns_favorites: ns_favorites,
                                onCardTapped: { card in
                                    vm.openModal(card, transitionSource: .favorites)
                                })
                            .frame(width: windowSize.width, alignment: .trailing)
                        )
                        .padding(.horizontal, 20)
                        .zIndex(1)

                    Divider()

                    CarouselView(
                        dataSource: vm,
                        delegate: vm,
                        isUserInteractionEnabled: vm.$modalVM.map({ $0 == nil }).eraseToAnyPublisher(),
                        initialActiveIdx: 3,
                        itemSize: Conf.Card.geo.size)
                }
                .padding(0)
                .onAppear {
                    vm.namespace = ns_carousel
                    vm.onDblClick = {
                        self.favoritesVM.toggleFavoriteStatus($0)
                    }
                }

                //-------------------------------------------------------
                // Backdrop blurred view (zIndex = 2)
                //-------------------------------------------------------
#if os(iOS)
                BlurView(active: vm.blur, onTap: { vm.dismissModal() })
                    .zIndex(2)
#elseif os(macOS)
                BlurView(material: .fullScreenUI, active: vm.blur, onTap: { vm.dismissModal() })
                    .zIndex(2)
#endif

                //-------------------------------------------------------
                // Modal View (zIndex = 3)
                //-------------------------------------------------------
                if let modalVM = vm.modalVM {
                    ModalView(
                        vm: modalVM,
                        ns_carousel: ns_carousel,
                        ns_favorites: ns_favorites,
                        isFavorite: favoritesVM.isFavorite(modalVM.card),
                        onClose: {
                            withWaitAnimation {
                                vm.dismissModal()
                            }
                        })
                    .frame(width: Conf.Modal.width(for: windowSize.width), height: geometry.size.height)
                    .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                    .zIndex(3)
                }
            }
        }
    }
}
