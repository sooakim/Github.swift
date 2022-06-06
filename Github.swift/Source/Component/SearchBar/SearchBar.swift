//
//  SearchBar.swift
//  Github.swift
//
//  Created by 김수아 on 2022/06/06.
//

import Foundation
import SwiftUI
import Then
import UIKit

struct SearchBar: UIViewRepresentable{
    @Binding var text: String
    
    static func dismantleUIView(_ uiView: UISearchBar, coordinator: _Coordinator) {
        
    }
    
    func makeCoordinator() -> _Coordinator {
        return _Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        return UISearchBar(frame: .zero).then{
            $0.delegate = context.coordinator
            $0.autocapitalizationType = .none
        }
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

extension SearchBar{
    final class _Coordinator: NSObject, UISearchBarDelegate{
        @Binding var text: String
        
        init(text: Binding<String>){
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text = searchText
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search Text"))
    }
}
