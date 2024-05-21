//
//  Model.swift
//  Spendable
//
//  Created by Sagar Ajudiya on 20/05/24.
//

import Foundation

struct FilterOption: Identifiable, Selectable {
    var id = UUID()
    var title: String?
    var isSelected = false
    var isButton = false
    var type: FilterType? = .custom
    
    static let filterType = [
        FilterOption(title: "Custom", isSelected: true, type: .custom),
        FilterOption(title: "Monthly", isButton: true, type: .monthly),
        FilterOption(title: "Daily", type: .daily),
        FilterOption(title: "Weekly", type: .weekly),
        FilterOption(title: "Yearly", type: .yearly),
        FilterOption(title: "All", type: .all)
    ]
}

struct DateData {
    var id = UUID()
    var categoryImg: String?
    var categoryName: String?
    var expense: Double?
    var income: Double?
    var transactionType: TransactionType? = .cash
    var note: String?
    var receipt: String?
}

struct MainData {
    var id = UUID()
    var date: String?
    var dateData: [DateData]?
    var total: Double? {
        didSet {
            let expense = dateData?.compactMap({$0.expense}).reduce(0, +) ?? 0
            let income = dateData?.compactMap({$0.income}).reduce(0, +) ?? 0
            total = income - expense
        }
    }
    
    static let transcationData: [MainData] = [
        MainData(date: "20 May 2024", dateData: [
            DateData(categoryImg: "bus_red", categoryName: "Transport", expense: 500, income: nil, transactionType: .cash, note: nil, receipt: nil),
            DateData(categoryImg: "bus_black", categoryName: "Shopping", expense: 200, income: nil, transactionType: .bank, note: nil, receipt: nil)
        ]),
        MainData(date: "21 May 2024", dateData: [DateData(categoryImg: "bus_red", categoryName: "Home", expense: nil, income: 500, transactionType: .debitCard, note: "Note done", receipt: "")])
    ]
}

enum TransactionType: String {
    case cash = "Cash"
    case creditCard = "Credit card"
    case debitCard = "Debit card"
    case bank = "Bank"
}

protocol Selectable {
    var id: UUID { get }
    var isSelected: Bool { get set }
}

extension Array where Element: Selectable {
    mutating func selectItem(withId id: UUID) {
        self = self.map { item in
            var mutableItem = item
            mutableItem.isSelected = (item.id == id)
            return mutableItem
        }
    }
}

enum FilterType {
    case custom
    case monthly
    case daily
    case weekly
    case yearly
    case all
    
    var caseTitle: String {
        switch self {
        case .custom:
            return "Custom"
        case .monthly:
            return "Monthly"
        case .daily:
            return "Daily"
        case .weekly:
            return "Weekly"
        case .yearly:
            return "Yearly"
        case .all:
            return "All"
        }
    }
    
    var dateTitle: String? {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        
        switch self {
        case .custom:
            return "May 6, 2024 - May 20, 2024"
        case .monthly:
            formatter.dateFormat = "MMMM, yyyy"
            return formatter.string(from: Date())
        case .daily:
            formatter.dateFormat = "MMM dd, yyyy"
            return formatter.string(from: Date())
        case .weekly:
            let calendar = Calendar.current
            var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
            components.weekday = calendar.firstWeekday
            let startDate = calendar.date(from: components)!
            components.weekday = calendar.firstWeekday + 6
            let endDate = calendar.date(from: components)!
            formatter.dateFormat = "MMM dd, yyyy"
            return "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
        case .yearly:
            formatter.dateFormat = "yyyy"
            return formatter.string(from: Date())
        case .all:
            return "All"
        }
    }
    
    var transactionData: [MainData]? {
        switch self {
        case .custom, .monthly, .yearly, .all:
            return [
                MainData(date: "21 May 2024", dateData: [DateData(categoryImg: "bus_red", categoryName: "Home", expense: nil, income: 500, transactionType: .debitCard, note: "Note done", receipt: "")]),
                MainData(date: "20 May 2024", dateData: [
                    DateData(categoryImg: "bus_red", categoryName: "Transport", expense: 500, income: nil, transactionType: .cash, note: nil, receipt: nil),
                    DateData(categoryImg: "bus_black", categoryName: "Shopping", expense: 200, income: nil, transactionType: .bank, note: nil, receipt: nil)
                ]),
                MainData(date: "19 May 2024", dateData: [
                    DateData(categoryImg: "bus_red", categoryName: "Transport", expense: 500, income: nil, transactionType: .cash, note: nil, receipt: nil),
                    DateData(categoryImg: "bus_black", categoryName: "Shopping", expense: nil, income: 200, transactionType: .bank, note: nil, receipt: nil),
                    DateData(categoryImg: "bus_black", categoryName: "Shopping", expense: 200, income: nil, transactionType: .bank, note: nil, receipt: nil),
                    DateData(categoryImg: "bus_black", categoryName: "Shopping", expense: 200, income: nil, transactionType: .bank, note: nil, receipt: nil),
                    DateData(categoryImg: "bus_black", categoryName: "Shopping", expense: nil, income: 100, transactionType: .bank, note: nil, receipt: nil),
                ]),
            ]
        case .daily:
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            let date = formatter.string(from: Date())
            return [
                MainData(date: date, dateData: [
                    DateData(categoryImg: "bus_black", categoryName: "Shopping", expense: 200, income: nil, transactionType: .bank, note: nil, receipt: nil),
                    DateData(categoryImg: "bus_black", categoryName: "Shopping", expense: 200, income: nil, transactionType: .bank, note: nil, receipt: nil),
                    DateData(categoryImg: "bus_black", categoryName: "Shopping", expense: 200, income: nil, transactionType: .bank, note: nil, receipt: nil),
                    DateData(categoryImg: "bus_red", categoryName: "Transport", expense: 500, income: nil, transactionType: .cash, note: nil, receipt: nil),
                    DateData(categoryImg: "bus_black", categoryName: "Shopping", expense: 200, income: nil, transactionType: .bank, note: nil, receipt: nil),
                ]),
            ]
        case .weekly:
            return nil
        }
    }
}
