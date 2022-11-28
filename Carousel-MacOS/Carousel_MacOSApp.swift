//
//  Carousel_MacOSApp.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

@main
struct Carousel_MacOSApp: App {

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
                .ignoresSafeArea()
        }
    }
}
