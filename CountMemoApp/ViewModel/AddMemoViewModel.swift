import Foundation
import SwiftUI

class AddMemoViewModel: ObservableObject {


    init() {

    }

    func addMemo(memo: Memo) {
        Memo.addMemo(memo: memo)
    }
}
