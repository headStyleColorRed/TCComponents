//
//  TCSearchBar.swift
//  RoundCross
//
//  Created by Rodrigo Labrador Serrano on 5/6/21.
//

import SwiftUI


public struct TCSearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    let backgroundColor: Color
    let placeholder: String
    let showCancelText: Bool

    public var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(4)
                .padding(.horizontal, 25)
                .background(backgroundColor)
                .cornerRadius(5)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }

            if isEditing && showCancelText {
                Button(action: {
                    self.isEditing = false
                    self.text = ""

                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }

    public init(text: Binding<String>, backgroundColor: Color,
                placeholder: String = "Search", showCancelText: Bool = true) {
        self._text = text
        self.backgroundColor = backgroundColor
        self.placeholder = placeholder
        self.showCancelText = showCancelText
    }
}



