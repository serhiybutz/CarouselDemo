//
//  CloseButtonView.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct CloseButtonView: View {

    var onTap: () -> Void

    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .font(.title)
            .foregroundColor(.secondary)
            .onTapGesture(perform: onTap)
    }
}
