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
                    .onTapGesture {
                        game.toggleSelection(card: card)
                    }
            }
            .padding()
            
            
            Spacer()

            Button {
                game.threeCardsFromDeckToTable()
            } label: {
                Text("Add more Cards")
            }
        }
        
        
//        ScrollView {
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
//                ForEach(game.model.deck) { item in
//                    CardView(card: item).aspectRatio(2/3, contentMode: .fit)
//                }
//            }
//        }
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(game: SetViewModel())
    }
}
