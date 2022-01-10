import Foundation
import RealmSwift

class MemoDB: Object {
    @objc dynamic var id: String = NSUUID().uuidString
    @objc dynamic var title: String?
    @objc dynamic var content: String!
    @objc dynamic var computedValue: String?
    @objc dynamic var registrationDate: String!

    override static func primaryKey() -> String? {
        return "id"
    }
}
