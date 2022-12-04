//
//  TitleView.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct TitleView: View {

    @State private var slowAnimations: Bool = debugAnimations

    var body: some View {

        let debug = Binding<Bool>(get: { slowAnimations }, set: { slowAnimations = $0; debugAnimations = $0 })

        VStack(alignment: .leading) {
            Text("Kungsleden Trail (Lapland)")
                .font(.largeTitle)
                .fontWeight(.bold)

            HStack {
                Text("Double tap to remove favorites")
                    .font(.subheadline)
                    .foregroundColor({
#if os(iOS)
                        Color(UIColor.secondaryLabel)
#elseif os(macOS)
                        Color(NSColor.secondaryLabelColor)
#endif
                    }())

                if debug.wrappedValue {
                    Text("Slow Animations On")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .background(Color.red)
                        .opacity(0.7)
                }
            }
        }
        .onTapGesture {
            withWaitAnimation {
                debug.wrappedValue.toggle()
            }
        }
    }
}
