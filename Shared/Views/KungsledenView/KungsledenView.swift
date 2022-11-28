//
//  KungsledenView.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import Carousel
import SwiftUI

struct KungsledenView: View {

    @StateObject var vm = KungsledenViewModel()

    var body: some View {

        ZStack {
            VStack {
                CarouselView(
                    dataSource: vm,
                    delegate: vm,
                    initialActiveIdx: 3,
                    itemSize: Conf.Carousel.cardSize)
            }
        }
    }
}
