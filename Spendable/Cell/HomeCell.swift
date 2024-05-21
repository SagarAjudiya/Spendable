//
//  HomeCell.swift
//  Spendable
//
//  Created by Sagar Ajudiya on 20/05/24.
//

import SwiftUI

struct HomeCell: View {
    
    @State var data: DateData?
    var expenseString = "-₹"
    var incomeString = "₹"
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(data?.categoryImg ?? "")
                .frame(width: 48, height: 48)
                .background(.appGreen)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(data?.categoryName ?? "Cate name")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.appWhite)
                    
                    Image(data?.receipt ?? "")
                        .background(Color.green.opacity(0.4))
                }
                
                Text(data?.note ?? "Note")
                    .font(.system(size: 16))
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(data?.expense == nil ? (incomeString + (data?.income?.description ?? "0")) : (expenseString + (data?.expense?.description ?? "0")))
                    .font(.system(size: 20))
                    .foregroundStyle(Color.appWhite)
                
                Text(data?.transactionType?.rawValue ?? "cash")
                    .font(.system(size: 16))
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
            }
            .frame(alignment: .trailing)
        }
    }
    
}

#Preview {
    HomeCell()
}
