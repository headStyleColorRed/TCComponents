//
//  TCRadioButtons.swift
//  RoundCross
//
//  Created by Rodrigo Labrador Serrano on 5/6/21.
//

import SwiftUI


public struct TCRadioButtons: View {
    @State var selectedId = String()
    let items: [String]
    let buttonColor: Color
    let radioFont: Font?
    let screenWidth: CGFloat // UIScreen.main.bounds.width
    let callback: (String) -> Void

    public var body: some View {
        VStack {
            ForEach(0..<items.count) { index in
                TCRadioButton(self.items[index],
                            callback: radioGroupCallback,
                            selectedID: selectedId, color: buttonColor, radioFont: radioFont)
            }
        }
        .frame(width: screenWidth / 1.4, alignment: .center)
    }

    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }

    public init(items: [String],
                buttonColor: Color,
                screenWidth: CGFloat,
                radioFont: Font?,
                callback: @escaping (String) -> Void) {
        self.items = items
        self.buttonColor = buttonColor
        self.screenWidth = screenWidth
        self.radioFont = radioFont
        self.callback = callback
    }
}


fileprivate struct TCRadioButton: View {
    let id: String
    let callback: (String) -> Void
    let selectedID: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let radioFont: Font?

    init( _ id: String, callback: @escaping (String) -> Void,
          selectedID: String, size: CGFloat = 20,
          color: Color, textSize: CGFloat = 14, radioFont: Font?) {
        self.id = id
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedID = selectedID
        self.callback = callback
        self.radioFont = radioFont
    }

    var body: some View {
        Button(action: {
            callback(id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Text(id)
                    .font(radioFont == nil ? Font.system(size: textSize): radioFont)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: selectedID == id ? "largecircle.fill.circle" : "circle")
                    .resizable()
                    .foregroundColor(color)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)            }
        }
        .padding([.top, .bottom], 10)
    }
}
