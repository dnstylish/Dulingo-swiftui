//
//  Charactor.swift
//  Dulingo
//
//  Created by Yuan on 04/04/2022.
//

import SwiftUI

struct Charactor: Identifiable {
    var id = UUID().uuidString
    var value: String
    var padding: CGFloat = 10
    var textSize: CGFloat = .zero
    var fontSize: CGFloat = 16
    var isShow: Bool = false
}

var charactors_: [Charactor] = [
    Charactor(value: "Lorem"),
    Charactor(value: "Ipsum"),
    Charactor(value: "is"),
    Charactor(value: "simply"),
    Charactor(value: "dummy"),
    Charactor(value: "text"),
    Charactor(value: "of"),
    Charactor(value: "the"),
    Charactor(value: "printing"),
    Charactor(value: "and"),
    Charactor(value: "typesetting"),
    Charactor(value: "industry")
]
