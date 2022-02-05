import Foundation
import RealmSwift

final class MemoStore: ObservableObject {

    @Published private(set) var memos: [Memo] = []

    init() {
        fetchMemos()
    }

    /// メモの取得
    func fetchMemos() {
        guard let realm = try? Realm() else {return }
        let memoResults = realm.objects(MemoDB.self)
        memos = memoResults.map(Memo.init)
    }

    /// メモの追加
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
        fetchMemos()
    }

    /// メモの更新
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
        fetchMemos()
    }

    /// メモの削除
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
