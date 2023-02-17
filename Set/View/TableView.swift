//
//  ContentView.swift
//  Set
//
//  Created by JY on 2023/02/10.
//

import SwiftUI

struct TableView: View {
    @ObservedObject var game: SetViewModel
    
    var body: some View {
        ZStack (alignment: .bottom){
            tableBody
            HStack {
                pileBody
                Spacer()
                deckBody
                    
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .ignoresSafeArea()
    }
    
    @State private var table = Set<Int>()
    @State private var pile = Set<Int>()
    @Namespace private var dealingNamespace
    
    var tableBody: some View {
        AspectVGrid(items: game.cardsInDeck.filter(isOnTable), aspectRatio: CardConstants.aspectRatio) { card in
            CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(2)
                .onTapGesture {
                    game.toggleSelection(card: card)
                }
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                .zIndex(zIndex(of: card))
        }
        .padding()
    }
    
    func isOnTable(card: SetViewModel.Card) -> Bool {
        table.contains(card.id)
    }
    
    func isNotOnTable(card: SetViewModel.Card) -> Bool {
        !table.contains(card.id)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cardsInDeck.filter(isNotOnTable)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
        .onTapGesture {
            withAnimation(Animation.easeInOut(duration: 2)) {
                if table.isEmpty {
                    let cardsOnTableId = game.cardsInDeck[0..<12].map { $0.id }
                    for id in cardsOnTableId {
                        table.insert(id)
                        game.cardStateToTable(id: id)
                    }
                } else {
                    if let indincesToMove = game.threeCardsFromDeckToTable() {
                        for id in indincesToMove {
                            table.insert(id)
                            game.cardStateToTable(id: id)
                        }
                    }
                }
            }
        }
    }
    
    private func zIndex(of card: SetViewModel.Card) -> Double {
        -Double(game.cardsInDeck.firstIndex { $0.id == card.id } ?? 0)
    }
    
    private func dealAnimation(for card: SetViewModel.Card) -> Animation {
        var delay = 0.0
        if let index = game.cardsOnTable.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cardsOnTable.count))
        }
        return Animation.easeInOut(duration: CardConstants.totalDealDuration).delay(delay)
    }
    
    var pileBody: some View {
        ZStack {
            ForEach(game.cardsInDiscardPile)  { card in
                CardView(card: card)
            }
            .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
        }
    }
    
    
    struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let deckWidth: CGFloat = 90
        static let deckHeight: CGFloat = deckWidth / aspectRatio
        static let totalDealDuration: Double = 2
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(game: SetViewModel())
    }
}
