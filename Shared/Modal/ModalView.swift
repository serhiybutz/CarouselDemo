//
//  ModalView.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct ModalView: View {

    @ObservedObject var vm: ModalViewModel

    let ns_carousel: Namespace.ID
    let ns_favorites: Namespace.ID

    let isFavorite: Bool

    @State var isGeometryMatchPhase: Bool = true
    @State var isTransitionComplete: Bool = false

    let onClose: () -> Void

    var body: some View {
        // We use EmptyView, because the modifier actually ignores
        // the value passed to its body() function.
        EmptyView()
            .modifier(
                ModalViewModifier(
                    card: vm.card,
                    ns_carousel: ns_carousel,
                    ns_favorites: ns_favorites,
                    transitionSource: vm.transitionSource,
                    isFavorite: isFavorite,
                    isGeometryMatchPhase: $isGeometryMatchPhase,
                    isTransitionComplete: $isTransitionComplete,
                    pct: isGeometryMatchPhase ? 0 : 1,
                    onClose: onClose
                )
            )
            .onAppear {
                isGeometryMatchPhase = true
                isTransitionComplete = false
                withWaitAnimation(.fly) {
                    isGeometryMatchPhase = false
                } complete: {
                    isTransitionComplete = true
                }
            }
    }
}

struct ModalViewModifier: AnimatableModifier {

    @Environment(\.windowSize) var windowSize: CGSize

    let card: Card

    let ns_carousel: Namespace.ID
    let ns_favorites: Namespace.ID
    @Namespace var ns_no_match

    let transitionSource: ModalTransitionSource

    let isFavorite: Bool

    @Binding var isGeometryMatchPhase: Bool
    @Binding var isTransitionComplete: Bool

    var pct: CGFloat
    let onClose: () -> Void

    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }

    func body(content: Content) -> some View {
        let params: ModalTransitionParams = transitionSource == .carousel
            ? CarouselModalTransitionParams(card: card, pct: pct, windowSize: windowSize)
            : FavoritesModalTransitionParams(card: card, pct: pct, windowSize: windowSize)

        let outerClipShape = params.outerClipShape(isTransitionComplete)

        GeometryReader { proxy in

            let verticalOffset = params.verticalOffset(with: proxy)
            let verticalTargetOffset = params.verticalTargetOffset

            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ModalContent(card: card, params: params)
                        .clipShape(params.innerClipShape)
                        .contentShape(params.innerClipShape)
                }
                .padding(.top, verticalTargetOffset) // add top offset to scroll view content!
                .padding(.bottom, Conf.Modal.bottomOffset)
                .overlay(StarView(isFavorite: isFavorite)
                    .padding(20)
                    .offset(CGSize(width: 0, height: verticalTargetOffset)) // add top offset to scroll view content!
                    .opacity(pct), alignment: .topLeading)
                .overlay(CloseButtonView(onTap: onClose)
                    .padding(20)
                    .offset(CGSize(width: 0, height: verticalTargetOffset)) // add top offset to scroll view content!
                    .opacity(pct), alignment: .topTrailing)
            }
            .clipShape(outerClipShape)
            .contentShape(outerClipShape)
            .offset(CGSize(width: 0, height: verticalOffset))
            // We cannot put matchedGeometryEffect() inside ScrollView (since the transition starts off from the card location, if the card is outside the scrollview, the content will be cut off)!
            .matchedGeometryEffect(id: card.id,
                                   in: isGeometryMatchPhase && transitionSource == .carousel ? ns_carousel : ns_no_match,
                                   properties: .position,
                                   isSource: false)
            .matchedGeometryEffect(id: card.id,
                                   in: isGeometryMatchPhase && transitionSource == .favorites ? ns_favorites : ns_no_match,
                                   properties: .position,
                                   isSource: false)
        }
        .shadow(radius: params.clipCornerRadius)
        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .move(edge: .bottom)))
    }
}

struct ModalContent: View {

    @Environment(\.colorScheme) var scheme
    @Environment(\.windowSize) var windowSize

    let card: Card
    let params: ModalTransitionParams

    var body: some View {
        VStack {
            Image(image: card.image)
                .resizable()
                // we need to scale image size from the card height to the target one as the animation progresses
                .frame(
                    width: params.imageWidth,
                    height: params.imageHeight
                ) // spicifying both width and height instead of one of them + aspectRation gives more performance improvement when animating
            VStack {
                Text(card.description)
            }
            .padding(Conf.Modal.padding)
        }
        .background({
#if os(macOS)
            VisualEffectView(material: .windowBackground)
#elseif os(iOS)
            VisualEffectView(uiVisualEffect: UIBlurEffect(style: scheme == .dark ? .dark : .light))
#endif
                }())
        .frame(width: Conf.Modal.width(for: windowSize.width)) // for some reason unfixed width was changing during the animation!
    }
}
