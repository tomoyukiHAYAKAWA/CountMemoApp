import Foundation
import UIKit

struct Memo: Identifiable, Hashable {
    var id: String = NSUUID().uuidString
    var title: String!
    var content: String!
    var computedValue: String!
    var registrationDate: String!
}

extension Memo {
    init(memoDB: MemoDB) {
        id = memoDB.id
        title = memoDB.title
        content = memoDB.content
        computedValue = memoDB.computedValue
        registrationDate = memoDB.registrationDate
    }
}
