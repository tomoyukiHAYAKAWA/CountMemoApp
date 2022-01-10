import Foundation
import SwiftUI
import RealmSwift

class MemoViewModel: ObservableObject {

    /// 登録日時をStringにして返す
    func toStringRegistrationDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy/MM/dd"
        let now = Date()
        return formatter.string(from: now)
    }

    /// テキスト内の数列を合計する
    func extractValue(text: String) -> String {
        var row: String = ""
        var rows: [String] = []
        var rowValues: [String] = []
        var extractValue: Int = 0
        text.forEach {
            if $0 == "\n" {
                rows.append(row)
                row = ""
            } else {
                row.append($0)
            }
        }

        rows.append(row)

        rows.forEach {
            let valueArray = $0.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
            let value = valueArray.joined()
            if value != "" {
                rowValues.append(value)
            }
        }

        rowValues.forEach {
            extractValue = extractValue + Int($0)!
        }

        return String(extractValue)
    }
}
