//
//  BlurView.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

#if os(iOS)

struct BlurView: View {

    @Environment(\.colorScheme) var scheme
    var active: Bool
    var onTap: () -> ()

    var body: some View {
        if active {
            VisualEffectView(uiVisualEffect: UIBlurEffect(style: scheme == .dark ? .dark : .light))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture(perform: self.onTap)
        }
    }
}

#elseif os(macOS)

struct BlurView: View {

    var material: NSVisualEffectView.Material
    var active: Bool
    var onTap: () -> ()

    var body: some View {
        if active {
            VisualEffectView(material: material)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture(perform: self.onTap)
        }
    }
}
#endif

#if os(iOS)

struct VisualEffectView: UIViewRepresentable {

    var uiVisualEffect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = uiVisualEffect
    }
}

#elseif os(macOS)

struct VisualEffectView: NSViewRepresentable {

    var material: NSVisualEffectView.Material

    func makeNSView(context: NSViewRepresentableContext<Self>) -> NSVisualEffectView {
        NSVisualEffectView()
    }

    func updateNSView(_ blurView: NSVisualEffectView, context: NSViewRepresentableContext<Self>) {
        blurView.blendingMode = .behindWindow
        blurView.material = material//.fullScreenUI
        blurView.state = .active
    }
}

#endif
