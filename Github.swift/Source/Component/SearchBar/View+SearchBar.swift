//
//  View+SearchBar.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/06.
//

import Foundation
import SwiftUI

extension View{
    func searchableCompat(text: Binding<String>) -> some View{
        VStack{
            SearchBar(text: text)
            self
        }
    }
}

struct View_searchableCompat_Previews: PreviewProvider {
    static var previews: some View {
        List{
            ForEach(0..<100){
                Text("\($0)")
            }
        }.searchableCompat(text: .constant("Search Text"))
    }
}

