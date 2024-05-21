//
//  HideViewModifier.swift
//  Spendable
//
//  Created by Sagar Ajudiya on 20/05/24.
//

import SwiftUI

struct HideViewModifier: ViewModifier {
    
    let isHidden: Bool
    
    @ViewBuilder func body(content: Content) -> some View {
        if isHidden {
            EmptyView()
        } else {
            content
        }
    }
}

// Extending on View to apply to all Views
extension View {
    
    func isHidden(if isHiddden: Bool) -> some View {
        ModifiedContent(content: self, modifier: HideViewModifier(isHidden: isHiddden))
    }
    
}
