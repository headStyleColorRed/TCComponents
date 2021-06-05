//
//  RCButton.swift
//  RoundCross
//
//  Created by Rodrigo Labrador Serrano on 22/5/21.
//

import SwiftUI


public struct TCProcessButton: View {
    @Binding var isEnabled: Bool
    let screenWidth: CGFloat // UIScreen.main.bounds.width
    let enabledText: String
    let disabledText: String
    let enabledColor: Color
    let disabledcolor: Color
    let buttonAction: () -> Void

    private var outputText: String {
        return isEnabled ? enabledText : disabledText
    }
    private var buttonColor: Color {
        return isEnabled ? enabledColor : disabledcolor
    }

    public var body: some View {
        Button(action: {
            buttonAction()
        }) {
            Text(outputText)
                .frame(width: screenWidth, height: 70, alignment: .center)
                .background(buttonColor)
                .foregroundColor(.white)
        }.disabled(!isEnabled)
    }

    public init(isEnabled: Binding<Bool>, screenWidth: CGFloat, enabledText: String, disabledText: String? = nil,
                enabledColor: Color, disabledcolor: Color, buttonAction: @escaping () -> Void) {
        self._isEnabled = isEnabled
        self.screenWidth = screenWidth
        self.enabledText = enabledText
        self.disabledText = disabledText == nil ? enabledText : disabledText!
        self.enabledColor = enabledColor
        self.disabledcolor = disabledcolor
        self.buttonAction = buttonAction
    }
}









