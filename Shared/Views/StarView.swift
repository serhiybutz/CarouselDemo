//
//  StarView.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct StarView: View {

    let isFavorite: Bool

    var body: some View {
        if isFavorite {
            Image(systemName: "star.fill")
                .shadow(radius: 3)
                .font(.title)
                .foregroundColor(.yellow.opacity(0.75))
        }
    }
}
