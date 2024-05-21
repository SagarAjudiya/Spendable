//
//  DateViewModel.swift
//  Spendable
//
//  Created by Sagar Ajudiya on 20/05/24.
//

import Foundation

class DateViewModel: ObservableObject {
    @Published var currentDate: Date

    private var calendar: Calendar

    init(date: Date = Date(), calendar: Calendar = Calendar.current) {
        self.currentDate = date
        self.calendar = calendar
    }

    func moveToPreviousMonth() {
        if let newDate = calendar.date(byAdding: .month, value: -1, to: currentDate) {
            currentDate = newDate
        }
    }

    func moveToNextMonth() {
        if let newDate = calendar.date(byAdding: .month, value: 1, to: currentDate) {
            currentDate = newDate
        }
    }

    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }
}
