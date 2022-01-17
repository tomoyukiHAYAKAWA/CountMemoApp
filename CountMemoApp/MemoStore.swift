import Foundation
import RealmSwift

final class MemoStore: ObservableObject {

    @Published private(set) var memos: [Memo] = []

    init() {
        fetchMemos()
    }

    func fetchMemos() {
        guard let realm = try? Realm() else {return }
        let memoResults = realm.objects(MemoDB.self)
        memos = memoResults.map(Memo.init)
    }

    func addMemo(memo: Memo) {
        let memoDB = MemoDB()
        memoDB.id = memo.id
        memoDB.title = memo.title
        memoDB.content = memo.content
        memoDB.computedValue = memo.computedValue
        memoDB.registrationDate = memo.registrationDate
        guard let realm = try? Realm() else {return }
        try? realm.write{
            realm.add(memoDB)
        }
    }

    func updateMemo(memo: Memo) {
        let memoDB = MemoDB()
        memoDB.id = memo.id
        memoDB.title = memo.title
        memoDB.content = memo.content
        memoDB.computedValue = memo.computedValue
        memoDB.registrationDate = memo.registrationDate
        guard let realm = try? Realm() else {return }
        try? realm.write {
            realm.add(memoDB, update: .modified)
        }
    }

    func deleteMemo(with indexSet: IndexSet) {
        var memo: Memo?
        indexSet.forEach ({ index in
            memo = memos[index]
        })
        guard let realm = try? Realm() else {return }
        let memoResults = realm.objects(MemoDB.self)
        guard let memoDB = memoResults.first(where: { $0.id == memo?.id }) else { return }
        try! realm.write {
            realm.delete(memoDB)
        }
        fetchMemos()
    }

}
