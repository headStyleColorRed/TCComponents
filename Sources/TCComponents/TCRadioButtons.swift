//
//  TCRadioButtons.swift
//  RoundCross
//
//  Created by Rodrigo Labrador Serrano on 5/6/21.
//

import SwiftUI

@available(iOS 13.0, *)
struct TCRadioButtons: View {
    @State var selectedId = String()
    let items: [String]
    let buttonColor: Color
    let screenWidth: CGFloat // UIScreen.main.bounds.width
    let callback: (String) -> Void

    var body: some View {
        VStack {
            ForEach(0..<items.count) { index in
                RadioButton(self.items[index],
                            callback: radioGroupCallback,
                            selectedID: selectedId, color: buttonColor)
            }
        }
        .frame(width: screenWidth / 1.4, alignment: .center)
    }

    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

@available(iOS 13.0, *)
fileprivate struct RadioButton: View {
    let id: String
    let callback: (String) -> Void
    let selectedID: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat

    init( _ id: String, callback: @escaping (String) -> Void,
          selectedID: String, size: CGFloat = 20,
          color: Color, textSize: CGFloat = 14) {
        self.id = id
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedID = selectedID
        self.callback = callback
    }

    var body: some View {
        Button(action: {
            callback(id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Text(id)
                    .font(Font.system(size: textSize))
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
