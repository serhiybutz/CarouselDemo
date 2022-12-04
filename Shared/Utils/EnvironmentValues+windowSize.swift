//
//  EnvironmentValues+windowSize.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

private struct WindowSize: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var windowSize: CGSize {
        get { self[WindowSize.self] }
        set { self[WindowSize.self] = newValue }
    }
}
