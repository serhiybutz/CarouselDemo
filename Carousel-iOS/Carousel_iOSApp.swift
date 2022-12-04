//
//  Carousel_iOSApp.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

@main
struct Carousel_iOSApp: App {
    @State var windowSize: CGSize = .zero

    var body: some Scene {
        WindowGroup {
            KungsledenView()
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
