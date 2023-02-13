//
//  SetModel.swift
//  Set
//
//  Created by JY on 2023/02/10.
//

import Foundation

struct SetModel {
    var cardsInDeck: [Card]
    var cardsOnTable: [Card]
    
    init() {
        cardsInDeck = []
        cardsOnTable = []
        for shape in threeStates.allCases {
            for number in threeStates.allCases {
                for shading in threeStates.allCases {
                    for color in threeStates.allCases {
                cardsInDeck.append(Card(content: Card.CardContent(shape: shape, number: number, shading: shading, color: color), id: cardsInDeck.count))
                    }
                }
            }
        }
        cardsInDeck.shuffle()
        for _ in 0..<12 {
            cardsOnTable.append(cardsInDeck.removeLast())
        }

    }
    
    func noMoreCardsInDeck() -> Bool {
        if cardsInDeck.count == 0 { return true }
        return false
    }
    
    mutating func threeCardsFromDeckToTable() {
        if cardsInDeck.count < 3 { return }
        for _ in 0..<3 {
            cardsOnTable.append(cardsInDeck.removeLast())
        }
    }
    
    var selectedCards: [Card] { cardsOnTable.filter { $0.isSelected } }
    
    mutating func toggleSelection(card: Card) {
        if let indexToSelect = cardsOnTable.firstIndex(where: { $0.id == card.id }) {
            cardsOnTable[indexToSelect].isSelected.toggle()
        }
    }
    
    mutating func matchSelected() {
        if let matched = isMatchedSet(selectedCards: selectedCards) {
            if matched {
                removeSelectedCards()
            } else {
                deselectCards()
            }
        }
    }
    
    mutating func removeSelectedCards() {
        for card in selectedCards {
            if let indexToRemove = cardsOnTable.firstIndex(where: { $0.id == card.id }) {
                cardsOnTable.remove(at: indexToRemove)
            }
        }
    }
    mutating func deselectCards() {
        for card in selectedCards {
            if let indexToUndo = cardsOnTable.firstIndex(where: { $0.id == card.id }) {
                cardsOnTable[indexToUndo].isSelected = false
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
        
        
        struct CardContent {
            var shape: threeStates
            var number: threeStates
            var shading: threeStates
            var color: threeStates
        }
    }
    
    enum threeStates: CaseIterable {
        case first, second, third
    }
}
