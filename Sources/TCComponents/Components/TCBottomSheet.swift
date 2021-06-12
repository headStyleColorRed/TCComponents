//
//  SwiftUIView.swift
//  
//
//  Created by Rodrigo Labrador Serrano on 12/6/21.
//

import SwiftUI

public enum TCBottomSheetHeight: CGFloat {
    case _1 = 0.1
    case _2 = 0.2
    case _3 = 0.3
    case _4 = 0.4
    case _5 = 0.5
    case _6 = 0.6
    case _7 = 0.7
    case _8 = 0.8
    case _9 = 0.9
}

public enum TCBottomSheetAppearance {
    case permaBottomShow(TCBottomSheetHeight)
    case hideAndToggle
    case standard
}

public struct TCBottomSheet<Content: View>: View {
    @Binding var showBottomSheet: Bool
    private let minHeight: TCBottomSheetAppearance
    private var sheetHeight: TCBottomSheetHeight
    private let showIndicator: Bool
    let content: Content

    public var body: some View {
        GeometryReader { geometry in
            TCBottomSheetView(isOpen: $showBottomSheet,
                              maxHeight: geometry.size.height * sheetHeight.rawValue,
                              minHeight: minHeight,
                              showIndicator: showIndicator) {
                content
            }
        }.edgesIgnoringSafeArea(.all)
    }

    public init(showBottomSheet: Binding<Bool>,
                sheetHeight: TCBottomSheetHeight = ._7,
                minHeight: TCBottomSheetAppearance = .standard,
                showIndicator: Bool = true,
                @ViewBuilder content: () -> Content) {
        self._showBottomSheet = showBottomSheet
        self.sheetHeight = sheetHeight
        self.minHeight = minHeight
        self.showIndicator = showIndicator
        self.content = content()
    }
}

private enum TCBottomSheetConstants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.3
}

private struct TCBottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool
    @GestureState private var translation: CGFloat = 0
    private let maxHeight: CGFloat
    private let minHeight: CGFloat
    private let showIndicator: Bool
    let content: Content

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    private var indicator: some View {
        RoundedRectangle(cornerRadius: TCBottomSheetConstants.radius)
            .fill(Color.gray)
            .frame(
                width: TCBottomSheetConstants.indicatorWidth,
                height: TCBottomSheetConstants.indicatorHeight
        ).onTapGesture {
            self.isOpen.toggle()
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                if showIndicator {
                    self.indicator.padding()
                }
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color.white)
            .cornerRadius(TCBottomSheetConstants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * TCBottomSheetConstants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }

    init(isOpen: Binding<Bool>, maxHeight: CGFloat,
         minHeight: TCBottomSheetAppearance, showIndicator: Bool,
         @ViewBuilder content: () -> Content) {

        switch minHeight {
        case .permaBottomShow(let ratio):
            self.minHeight = maxHeight * ratio.rawValue
        case .hideAndToggle:
            self.minHeight = 0
        case .standard:
            self.minHeight = maxHeight * TCBottomSheetConstants.minHeightRatio
        }
        self.showIndicator = showIndicator
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }
}
