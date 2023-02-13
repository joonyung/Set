//
//  SetViewModel.swift
//  Set
//
//  Created by JY on 2023/02/10.
//

import SwiftUI

class SetViewModel: ObservableObject {
    typealias Card = SetModel.Card
    @Published private var model = SetModel()
    
    
    var cardsInDeck: [Card] {
        return model.cardsInDeck
    }
    
    var cardsOnTable: [Card] {
        return model.cardsOnTable
    }

    
    
    
//    MARK: - Intent(s)
    func threeCardsFromDeckToTable() {
        model.threeCardsFromDeckToTable()
    }
    
    func matchSelected() {
        model.matchSelected()
    }
    
    func toggleSelection(card: Card) {
        model.toggleSelection(card: card)
        model.matchSelected()
    }
    
    func noMoreCardsInDeck() -> Bool {
        model.noMoreCardsInDeck()
    }
}
