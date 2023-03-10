//
//  CardView.swift
//  Set
//
//  Created by JY on 2023/02/10.
//

import SwiftUI

struct CardView: View {
    var card: SetViewModel.Card
    
    var body: some View {
        let rect = RoundedRectangle(cornerRadius: 10)
        GeometryReader { geometry in
            ZStack{
                rect.foregroundColor(.white)
                if card.isSelected {
                    rect.strokeBorder(lineWidth: 8).foregroundColor(.cyan)
                    
                } else {
                    rect.strokeBorder(lineWidth: 3).foregroundColor(.gray)
                }
                
                drawNumberOfShape
                    .padding()
            }
            
        }
        
    }
    
    @ViewBuilder
    private var drawNumberOfShape: some View {
        let shape = drawShape.aspectRatio(2/1, contentMode: .fit)
        
        switch card.content.number {
        case .first:
            VStack{
                shape
            }
        case .second:
            VStack{
                shape
                shape
            }
        case .third:
            VStack{
                shape
                shape
                shape
            }
        }
    }
    
    @ViewBuilder
    private var drawShape: some View {
        switch card.content.shape {
        case .first:
            drawColor(drawShading(Ellipse()))
        case .second:
            drawColor(drawShading(Diamond()))
        case .third:
            drawColor(drawShading(Rectangle()))
        }
    }
    
    @ViewBuilder
    private func drawColor<Drawing>(_ shape: Drawing) -> some View
    where Drawing: View {
        switch card.content.color {
        case .first:
            shape.foregroundColor(.pink)
        case .second:
            shape.foregroundColor(.indigo)
        case .third:
            shape.foregroundColor(.green)
        }
    }
    
    @ViewBuilder
    private func drawShading<Drawing>(_ shape: Drawing) -> some View
    where Drawing: Shape {
        switch card.content.shading {
        case .first:
            shape.stroke(lineWidth: 4)
        case .second:
            shape.fill()
        case .third:
            shape.fill().opacity(0.3)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = SetModel.Card(isSelected: false, content: SetModel.Card.CardContent(shape: .first, number: .third, shading: .first, color: .third), id: 0)
        CardView(card: card)
    }
}
