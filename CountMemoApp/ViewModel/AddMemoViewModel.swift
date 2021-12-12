import Foundation
import SwiftUI

class AddMemoViewModel: ObservableObject {

    func addMemo(memo: Memo) {
        Memo.addMemo(memo: memo)
    }

    /// 登録日時をStringにして返す
    func toStringRegistrationDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy/MM/dd"
        let now = Date()
        return formatter.string(from: now)
    }

    /// テキスト内の数列を合計する
    func extractNumber(text: String) -> Int {
        return 0
    }
}
