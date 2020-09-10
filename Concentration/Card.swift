//
//  Card.swift
//  Concentration
//
//  Created by ジョナサン on 9/9/20.
//  Copyright © 2020 ジョナサン. All rights reserved.
//

import Foundation

//struct: has no inheritence, value type/!reference type, when passed a copy made
struct Card {
    var identifier: Int
    var isFaceUp = false
    var isMatched = false

    static var identifierFactory = 0

    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return identifierFactory
    }

    init(identifier identifier: Int){
        self.identifier = identifier
    }

    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
