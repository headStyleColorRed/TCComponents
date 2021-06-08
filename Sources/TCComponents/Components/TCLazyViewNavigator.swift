//
//  LazyViewNavigator.swift
//  Roster
//
//  Created by Rodrigo Labrador Serrano on 8/6/21.
//

import SwiftUI

struct TCLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
