import Foundation
import SwiftUI
import RealmSwift

class MemoListViewModel: ObservableObject {
    private var notificationTokens: [NotificationToken] = []

    @Published var memos: Results<Memo> = Memo.fetchAllMemos()

    init() {
        notificationTokens.append(memos.observe { change in
            switch change {
            case let .initial(results):
                self.memos = results
            case let .update(results, _, _, _):
                self.memos = results
            case let .error(error):
                print(error.localizedDescription)
            }
        })
    }

    deinit {
        notificationTokens.forEach { $0.invalidate() }
    }

}
