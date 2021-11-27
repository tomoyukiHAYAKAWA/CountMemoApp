import Foundation
import SwiftUI

class MemoListViewModel: ObservableObject {
    @Published private(set) var memos: [Memo] = [Memo.init(title: "メモ1", content: "あああああ", sumCount: "2000", registrationDate: "2021/11/25"),
                                                 Memo.init(title: "メモ2", content: "いいいいい", sumCount: "21000", registrationDate: "2021/11/27"),
                                                 Memo.init(title: nil, content: "いいいいい", sumCount: nil, registrationDate: "2021/11/28")]
}
