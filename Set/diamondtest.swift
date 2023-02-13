//
//  diamondtest.swift
//  Set
//
//  Created by JY on 2023/02/13.
//

import SwiftUI

struct diamondtest: View {
    var body: some View {
//        VStack{
            Diamond().aspectRatio(2/1, contentMode: .fit)
//        }
//        Rectangle()
    }
}

struct diamondtest_Previews: PreviewProvider {
    static var previews: some View {
        diamondtest()
    }
}
