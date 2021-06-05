//
//  TCTextField.swift
//  RoundCross
//
//  Created by Rodrigo Labrador Serrano on 5/6/21.
//

import SwiftUI

// MARK: - Inputs
public enum TCTextfieldTypes {
    case text
    case password
}


public struct TCTextField: View {
    @Binding var fieldInput: String
    let inputType: TCTextfieldTypes
    let placeholder: String
    let iconImage: Image?

    public var body: some View {
        VStack {
            HStack {
                if let iconImage = iconImage {
                    iconImage
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 30)
                }
                if inputType == .text {
                    TextField(placeholder, text: $fieldInput)
                        .textFieldStyle(TCTextFieldStyle())
                } else {
                    SecureField(placeholder, text: $fieldInput)
                        .textFieldStyle(TCTextFieldStyle())
                }
            }
        }
        .padding()
        .background(Color.white.opacity(fieldInput.isEmpty ? 0 : 0.12))
        .cornerRadius(15)
        .padding(.horizontal, 20)
    }

    public init(fieldInput: Binding<String>, inputType: TCTextfieldTypes, placeholder: String, iconImage: Image?) {
        self._fieldInput = fieldInput
        self.inputType = inputType
        self.placeholder = placeholder
        self.iconImage = iconImage
    }
}


fileprivate struct TCTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(5)
            .background(Color.init(hex: "DADADA"))
            .cornerRadius(5)
    }
}
