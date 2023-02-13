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
        VStack{
            AspectVGrid(items: game.cardsOnTable, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .padding(2)
                    .onTapGesture {
                        game.toggleSelection(card: card)
                    }
            }
            .padding()
            
            Spacer()

            if !game.noMoreCardsInDeck() {
                Button {
                    game.threeCardsFromDeckToTable()
                } label: {
                    Text("Deal 3 More Cards")
                }
            }
        }

    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(game: SetViewModel())
    }
}
