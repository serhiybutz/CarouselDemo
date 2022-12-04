//
//  Carousel_MacOSApp.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

@main
struct Carousel_MacOSApp: App {
    @State var windowSize: CGSize = .zero

    var body: some Scene {
        WindowGroup {
            KungsledenView()
                .frame(
                    minWidth: 300,
                    idealWidth: 700,
                    maxWidth: .infinity,
                    minHeight: 400,
                    idealHeight: 800,
                    maxHeight: .infinity)
                .overlay(GeometryReader { proxy in
                    Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
                })
                .onPreferenceChange(SizePreferenceKey.self) { value in
                    windowSize = value
                }
                .environment(\.windowSize, windowSize)
        }
    }
}
