//
//  Diamond.swift
//  Set
//
//  Created by JY on 2023/02/13.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var p = Path()
        p.move(to: CGPoint(x: center.x, y: center.y + rect.height / 2))
        p.addLine(to: CGPoint(x: center.x + rect.width / 2, y: center.y))
        p.addLine(to: CGPoint(x: center.x, y: center.y - rect.height / 2))
        p.addLine(to: CGPoint(x: center.x - rect.width/2, y: center.y))
        p.addLine(to: CGPoint(x: center.x, y: center.y + rect.height / 2))
        
        return p
    }
}
