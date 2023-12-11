//
//  DateString.swift
//  PJ2T12_Again12
//
//  Created by 권운기 on 12/11/23.
//

import Foundation
import SwiftUI

extension String { // 날짜 포멧 변경
    func stringFromDate(now: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: now)
    }
}
