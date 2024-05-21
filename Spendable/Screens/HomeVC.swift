//
//  HomeVC.swift
//  Spendable
//
//  Created by Sagar Ajudiya on 20/05/24.
//

import SwiftUI

struct HomeVC: View {
    
    @State private var filterOptions = FilterOption.filterType
    @State private var selectedObj = FilterOption()
    @StateObject private var viewModel = DateViewModel()
    
    var totalIncome: Int {
        let totalIncome: Double = selectedObj.type?.transactionData?.reduce(0) { (result, mainData) in
            let expenseSum = mainData.dateData?.compactMap { $0.income }.reduce(0, +) ?? 0
            return result + expenseSum
        } ?? 0
        return Int(totalIncome)
    }
    
    var totalExpenses: Int {
        let totalExpenses: Double = selectedObj.type?.transactionData?.reduce(0) { (result, mainData) in
            let expenseSum = mainData.dateData?.compactMap { $0.expense }.reduce(0, +) ?? 0
            return result + expenseSum
        } ?? 0
        return Int(totalExpenses)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Spendable")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.appWhite)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 18) {
                    ForEach(filterOptions) { obj in
                        Text(obj.type?.caseTitle ?? "")
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .foregroundStyle(Color.appWhite)
                            .background {
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(style: StrokeStyle(lineWidth: 1))
                                    .foregroundStyle(obj.isSelected ? Color.appMint : Color.appGrey)
                            }
                            .onTapGesture {
                                viewModel.currentDate = Date()
                                filterOptions.selectItem(withId: obj.id)
                                selectedObj = filterOptions.first(where: {$0.id == obj.id}) ?? FilterOption()
                            }
                    }
                }
                .padding(.horizontal)
            }
//            .scrollIndicators(.never)
            .frame(height: 80)
                        
            HStack {
                Button {
                    viewModel.moveToPreviousMonth()
                } label: {
                    Image(systemName: "arrow.backward")
                        .imageScale(.large)
                        .tint(.appMint)
                }
                .isHidden(if: !selectedObj.isButton)
                
                Rectangle()
                    .foregroundStyle(Color.gray)
                    .frame(height: 2)
                    .isHidden(if: selectedObj.isButton)
                
                Text((selectedObj.type == .monthly ? viewModel.formattedDate() : selectedObj.type?.dateTitle) ?? "")
                    .foregroundStyle(Color.appMint)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                
                Rectangle()
                    .foregroundStyle(Color.gray)
                    .frame(height: 2)
                    .isHidden(if: selectedObj.isButton)
                
                Button {
                    viewModel.moveToNextMonth()
                } label: {
                    Image(systemName: "arrow.forward")
                        .imageScale(.large)
                        .tint(.appMint)
                }
                .isHidden(if: !selectedObj.isButton)
            }
            .padding(.horizontal)
            
            HStack {
                Spacer()
                VStack(spacing: 4) {
                    Text("Income")
                        .foregroundStyle(Color.gray)
                        .fontWeight(.medium)
                    Text("₹\(totalIncome)")
                        .foregroundStyle(Color.appWhite)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Spacer()
                VStack(spacing: 4) {
                    Text("Spent")
                        .foregroundStyle(Color.gray)
                        .fontWeight(.medium)
                    Text("₹\(totalExpenses)")
                        .foregroundStyle(Color.appWhite)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Spacer()
                VStack(spacing: 4) {
                    Text("Balance")
                        .foregroundStyle(Color.gray)
                        .fontWeight(.medium)
                    Text("₹\(totalIncome - totalExpenses)")
                        .foregroundStyle(Color.appWhite)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
            }
            .padding(.vertical)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundStyle(Color.appGrey)
            }
            .padding()
            
            ScrollView(.vertical) {
                if let transactionData = selectedObj.type?.transactionData, !transactionData.isEmpty {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(transactionData, id: \.id) { data in
                            HStack {
                                Text(data.date ?? "20 May 2024")
                                    .font(.system(size: 18))
                                    .foregroundStyle(Color.appWhite)
                                
                                Spacer()
                                
                                let expense = data.dateData?.compactMap({$0.expense}).reduce(0, +) ?? 0
                                let income = data.dateData?.compactMap({$0.income}).reduce(0, +) ?? 0
                                Text("₹\(Int(income - expense))")
                                    .font(.system(size: 18))
                                    .foregroundStyle(Color.appWhite)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.appGrey)
                            
                            ForEach(data.dateData ?? [], id: \.id) { dateData in
                                HomeCell(data: dateData)
                            }
                            .padding(.horizontal)
                        }
                    }
                } else {
                    VStack {
                        Text("No Data Available")
                            .font(.system(size: 18))
                            .foregroundStyle(Color.appWhite)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.appGrey)
                    .cornerRadius(10)
                    .padding()
                }
            }
            
            Spacer()
        }
        .background(.appBlack)
    }
}

#Preview {
    HomeVC()
}
