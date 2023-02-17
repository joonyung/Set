//
//  SetModel.swift
//  Set
//
//  Created by JY on 2023/02/10.
//

import Foundation

struct SetModel {
    var cards: [Card]
//    var cardsOnTable: [Card]
//    var cardsInPile: [Card]
    
    var cardsInDeck: [Card] { cards.filter { $0.state == .deck} }
    var cardsOnTable: [Card] { cards.filter { $0.state == .table} }
    var cardsInPile: [Card] { cards.filter { $0.state == .pile} }
    var selectedCards: [Card] { cards.filter { $0.isSelected } }
    
    init() {
        cards = []
//        cardsOnTable = []
//        cardsInPile = []
        for shape in threeStates.allCases {
            for number in threeStates.allCases {
                for shading in threeStates.allCases {
                    for color in threeStates.allCases {
                cards.append(Card(content: Card.CardContent(shape: shape, number: number, shading: shading, color: color), id: cards.count))
                    }
                }
            }
        }
//        cardsInDeck.shuffle()
//        for _ in 0..<12 {
//            cardsOnTable.append(cardsInDeck.removeLast())
//        }

    }
    
    mutating func threeCardsFromDeckToTable() -> [Int]? {
        if cardsInDeck.count < 3 { return nil }
//        for _ in 0..<3 {
//            cardsOnTable.append(cardsInDeck.removeLast())
//        }
        let deckCount = cardsInDeck.count
        let lastIdInDeck = cardsInDeck[deckCount - 3..<deckCount].map { $0.id }
        for id in lastIdInDeck {
            if let indexToMove = cards.firstIndex(where: { $0.id == id }) {
                cards[indexToMove].state = .table
            }
        }
        
        return lastIdInDeck
    }
    
    mutating func toggleSelection(card: Card) {
        if let indexToSelect = cards.firstIndex(where: { $0.id == card.id }) {
            cards[indexToSelect].isSelected.toggle()
        }
    }
    
    mutating func cardStateToTable(id: Int) {
        if let indexToTable = cards.firstIndex(where: { $0.id == id} ) {
            cards[indexToTable].state = .table
        }
    }
    
    mutating func cardStateToPile(id: Int) {
        if let indexToTable = cards.firstIndex(where: { $0.id == id} ) {
            cards[indexToTable].state = .table
        }
    }
    
    mutating func removeSelectedCards() {
        for card in selectedCards {
            if let indexToRemove = cards.firstIndex(where: { $0.id == card.id }) {
                cards[indexToRemove].isSelected = false
                cards[indexToRemove].state = .pile
            }
        }
    }
    mutating func deselectCards() {
        for card in selectedCards {
            if let indexToDeselect = cards.firstIndex(where: { $0.id == card.id }) {
                cards[indexToDeselect].isSelected = false
            }
        }
    }
    
    mutating func tryMatchingSelectedCards() {
        if let matched = isMatchedSet(selectedCards: selectedCards) {
            if matched {
                removeSelectedCards()
            } else {
                deselectCards()
            }
        }
    }
    
    func isMatchedSet(selectedCards: [Card]) -> Bool? {
        if selectedCards.count != 3 { return nil }
        
        if !noTwoIdenticalFeatures(feature1: selectedCards[0].content.color, feature2: selectedCards[1].content.color, feature3: selectedCards[2].content.color) { return false }
        if !noTwoIdenticalFeatures(feature1: selectedCards[0].content.number, feature2: selectedCards[1].content.number, feature3: selectedCards[2].content.number) { return false }
        if !noTwoIdenticalFeatures(feature1: selectedCards[0].content.shape, feature2: selectedCards[1].content.shape, feature3: selectedCards[2].content.shape) { return false }
        if !noTwoIdenticalFeatures(feature1: selectedCards[0].content.shading, feature2: selectedCards[1].content.shading, feature3: selectedCards[2].content.shading) { return false }
        
        return true
    }
    
    func noTwoIdenticalFeatures(feature1: threeStates, feature2: threeStates, feature3: threeStates) -> Bool {
        var numberOfSameOnes = 0
        if feature1 == feature2 { numberOfSameOnes += 1 }
        if feature2 == feature3 { numberOfSameOnes += 1 }
        if feature3 == feature1 { numberOfSameOnes += 1 }
        
        if numberOfSameOnes == 1 { return false }
        return true
    }
    
    struct Card: Identifiable {
        var isSelected: Bool = false
        var content: CardContent
        var id: Int
        var state: CardState = .deck
        
        
        struct CardContent {
            var shape: threeStates
            var number: threeStates
            var shading: threeStates
            var color: threeStates
        }
        
        enum CardState {
            case deck, table, pile
        }
    }
    
    enum threeStates: CaseIterable {
        case first, second, third
    }
}
