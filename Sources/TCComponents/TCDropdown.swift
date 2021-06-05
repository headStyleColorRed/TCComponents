//
//  TCDropdown.swift
//  RoundCross
//
//  Created by Rodrigo Labrador Serrano on 5/6/21.
//

import SwiftUI


struct TCDropdown: View {
    @State private var searchWord = String()
    let titleQuestion: String
    @State var options: [TCOptions]
    let screenWidth: CGFloat // UIScreen.main.bounds.width
    let placeholder: String
    let backgroundcolor: Color
    let noResultsText: String
    var chosenOption: (String) -> Void

    private var scrollHeight: CGFloat = 200
    private var noResults = TCOptions(text: "No results...", isNoResult: true)

    private var filteredArrays: [TCOptions] {
        guard !searchWord.isEmpty else { return options }
        let availableOptions = options.filter({ $0.text.contains(searchWord)})
        return availableOptions.isEmpty ? [noResults] : availableOptions
    }

    private var title: String {
        guard let selectedAnswer = options.first(where: { $0.isSelected })?.text else {
            return titleQuestion
        }
        return "\(titleQuestion) \(selectedAnswer)"
    }

    struct TCOptions {
        var index: Int = 1
        var isSelected: Bool = false
        var text: String
        var isNoResult: Bool = false
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .lineLimit(1)
                .padding(.top, 10)
                .padding(.leading, 15)
                .foregroundColor(.gray)
            TCSearchBar(text: $searchWord,
                        backgroundColor: Color.init(hex: "EDEBEB"),
                        placeholder: placeholder, showCancelText: false)

            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach(0..<filteredArrays.count, id: \.self) { index in
                        let option = filteredArrays.elementIn(index)
                        ZStack(alignment: .leading) {
                            optionColor(option)
                                    .cornerRadius(5)
                            Text(option?.text ?? "")
                                .lineLimit(1)
                                .foregroundColor(optionTextColor(option))
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 5)
                        }.onTapGesture {
                            selectOptionIn(row: index)
                        }
                    }
                    .padding([.leading, .trailing], 15)
                    .padding(.bottom, 10)

                }
            }
            .frame(height: scrollHeight)
        }
        .frame(width: screenWidth / 1.3, alignment: .center)
        .background(backgroundcolor)
        .cornerRadius(10)
    }

    init(titleQuestion: String = "Select an option", options: [String], screenWidth: CGFloat,
         placeholder: String = "Search", backgroundcolor: Color = Color.gray,
         noResultsText: String = "No results...", chosenOption: @escaping (String) -> Void) {
        self.titleQuestion = titleQuestion
        self.placeholder = placeholder
        self.backgroundcolor = backgroundcolor
        self.noResultsText = noResultsText
        self.chosenOption = chosenOption

        var tcOptions = [TCOptions]()
        options.forEach({ tcOptions.append(TCOptions(text: $0)) })
        self.options = tcOptions
        self.screenWidth = screenWidth
        self.scrollHeight = scrollHeight(optionsAmount: options.count)
    }

    private func optionColor(_ option: TCOptions?) -> Color {
        return option?.isSelected == true ? Color.init(hex: "DAE8FD") : .white
    }

    private func optionTextColor(_ option: TCOptions?) -> Color {
        return option?.isSelected == true ? Color.init(hex: "5A93F8") : .black
    }

    private func selectOptionIn(row: Int) {
        guard options.elementIn(row)?.isNoResult == false else { return }

        for i in options.indices {
            options[i].isSelected = false
        }
        options[row].isSelected = true
        chosenOption(options[row].text)
    }

    private func scrollHeight(optionsAmount: Int) -> CGFloat {
        switch optionsAmount {
        case 0, 1:
            return 40
        case 2:
            return 90
        case 3:
            return 140
        default:
            return 190
        }
    }
}
