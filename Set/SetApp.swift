//
//  SetApp.swift
//  Set
//
//  Created by JY on 2023/02/10.
//

import SwiftUI

@main
struct SetApp: App {
    private let game = SetViewModel()
    
    var body: some Scene {        
        WindowGroup {
            TableView(game: game)
        }
    }
}
