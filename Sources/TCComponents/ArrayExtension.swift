//
//  ArrayExtension.swift
//  RoundCross
//
//  Created by Rodrigo Labrador Serrano on 5/6/21.
//

import Foundation

extension Array {
    func firstElements(_ number: Int) -> [Element] {
        var array = [Element]()
        for (index, element) in self.enumerated() {
            if index == number { return array }
            array.append(element)
        }
        return array
    }

    func elementIn(_ index: Int) -> Element? {
        if 0 <= index && index < count {
            return self[index]
        } else {
            return nil
        }
    }

    /// Tries to insert the `element` at the specified `index`.
    /// It returns without changes if `index` is not a valid index for `self`.
    mutating func safeInsert(_ element: Element, at index: Int) {
        guard index >= 0, index <= count else { return }
        self.insert(element, at: index)
    }

    /// Tries to insert the contents of `elements` at the specified `index`.
    /// It returns without changes if `index` is not a valid index for `self`.
    mutating func safeInsert(contentsOf elements: [Element], at index: Int) {
        guard index >= 0, index <= count else { return }
        self.insert(contentsOf: elements, at: index)
    }
}
