//
//  ModalTransitionParams.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

protocol ModalTransitionParams {
    var imageWidth: CGFloat { get }
    var imageHeight: CGFloat { get }

    var clipCornerRadius: CGFloat { get }

    var innerClipShape: AnyShape { get }
    func outerClipShape(_ isTransitionComplete: Bool) -> AnyShape

    func verticalOffset(with proxy: GeometryProxy) -> CGFloat
    var verticalTargetOffset: CGFloat { get }
}
