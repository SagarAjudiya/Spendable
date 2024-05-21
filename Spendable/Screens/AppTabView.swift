//
//  AppTabView.swift
//  Spendable
//
//  Created by Sagar Ajudiya on 20/05/24.
//

import SwiftUI

struct AppTabView: View {
    
    @State private var selectedTabIndex = 0
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            HomeVC()
                .tabItem {
                    Image(.imgTab1)
                        .imageScale(.medium)
                }
            
            BudgetVC()
                .tabItem {
                    Image(.imgTab2)
                }
            
            BudgetVC()
                .tabItem {
                    Image(.imgTab3)
                }
            
            BudgetVC()
                .tabItem {
                    Image(.imgTab4)
                }
            
            BudgetVC()
                .tabItem {
                    Image(.imgTab5)
                }
        }
        .tint(Color.appMint)
        .onAppear {
            UITabBar.appearance().backgroundColor = .appGrey
            UITabBar.appearance().unselectedItemTintColor = .appWhite
        }
    }
    
}

#Preview {
    AppTabView()
}
