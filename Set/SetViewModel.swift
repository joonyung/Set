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
        return model.cards
    }
    
    var cardsOnTable: [Card] {
        return model.cardsOnTable
    }
    
    var cardsInDiscardPile: [Card] {
        return model.cardsInPile
    }
    
    func noMoreCardsInDeck() -> Bool {
        model.cards.isEmpty
    }
    
//    MARK: - Intent(s)
    func threeCardsFromDeckToTable() -> [Int]? {
        model.threeCardsFromDeckToTable()
    }
    
    func tryMatchingSelectedCards() {
        model.tryMatchingSelectedCards()
    }
    
    func toggleSelection(card: Card) {
        model.toggleSelection(card: card)
    }
    
    func cardStateToTable(id: Int) {
        model.cardStateToTable(id: id)
    }
    
    func cardStateToPile(id: Int) {
        model.cardStateToPile(id: id)
    }
    
}
