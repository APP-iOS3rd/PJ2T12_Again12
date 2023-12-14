//
//  Calendar.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/13.
//

import Foundation

extension Calendar {
    func startOfMonth(for date: Date) -> Date {
        return self.date(from: self.dateComponents([.year, .month], from: self.startOfDay(for: date)))!
    }

    func endOfMonth(for date: Date) -> Date {
        return self.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(for: date))!
    }
}
