//
//  SwiftUIView.swift
//  
//
//  Created by Rodrigo Labrador Serrano on 11/6/21.
//

import SwiftUI

public enum TCCurvedViewType {
    public enum Side { case top, bottom }
    public enum Direction { case inwards, outwards}
}

struct TCCurvedView<Content: View>: View {
    private let content: Content
    private let side: TCCurvedViewType.Side
    private let direction: TCCurvedViewType.Direction
    private let curveAmount: CGFloat
    private let backgroundColor: Color
    private let width: CGFloat
    private let height: CGFloat
    private var curveOffset: CGFloat {
        return direction == .outwards ? curveAmount : curveAmount * -1
    }

    init(side: TCCurvedViewType.Side = .top,
                direction: TCCurvedViewType.Direction = .outwards, curveAmount: CGFloat = 40,
                backgroundColor: Color = .gray, width: CGFloat = 300,
                height: CGFloat = 300, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.side = side
        self.direction = direction
        self.curveAmount = curveAmount
        self.backgroundColor = backgroundColor
        self.width = width
        self.height = height
    }

    var body: some View {
        VStack {
            VStack {
                content
            }
            .frame(width: width, height: height, alignment: .top)
            .background(CurvedViewShape(curveOffset: curveOffset, side: side)
                            .fill(backgroundColor))
        }
        .edgesIgnoringSafeArea(.all)

    }
}

private struct CurvedViewShape: Shape {
    let curveOffset: CGFloat
    let side: TCCurvedViewType.Side

    func path(in rect: CGRect) -> Path {
        var path = Path()
        switch side {
        case .top:
            path.move(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addQuadCurve(to: CGPoint(x: rect.width, y: 0),
                              control: CGPoint(x: rect.width / 2, y: 0 - curveOffset))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        case .bottom:
            path.move(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addQuadCurve(to: CGPoint(x: 0, y: rect.height),
                              control: CGPoint(x: rect.width / 2, y: rect.height + curveOffset))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
        return path
    }
}
