import Foundation
import RealmSwift

class Memo: Object, Identifiable {
    @objc dynamic var id: String = NSUUID().uuidString
    @objc dynamic var title: String?
    @objc dynamic var content: String!
    @objc dynamic var sumCount: String?
    @objc dynamic var registrationDate: String!

    private static var realm = try! Realm()

    override static func primaryKey() -> String? {
        return "id"
    }

    static func fetchAllMemos() -> Results<Memo> {
        return realm.objects(Memo.self)
    }

    static func addMemo(memo: Memo) {
        try! realm.write {
            realm.add(memo)
        }
    }

    static func updateMemo(memo: Memo) {
        try! realm.write {
            realm.add(memo, update: .modified)
        }
    }

    static func deleteMemo(memo: Memo) {
        try! realm.write {
            realm.delete(memo)
        }
    }
}
