//
//  CardTitleView.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct CardTitleView: View {

    let item: Card

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.largeTitle)
                .fontWeight(.bold)

        }
        .padding(20).padding(.leading, 25)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(
            LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .leading, endPoint: .trailing)
        )
        .foregroundColor(.white)
        .scaleEffect(0.75, anchor: .topLeading)
    }
}
