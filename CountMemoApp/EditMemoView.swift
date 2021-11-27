import SwiftUI

struct EditMemoView: View {
    var memo: Memo
    var body: some View {
        NavigationView {
            let title = memo.title ?? "タイトルなし"
            Text(title)
            .listStyle(PlainListStyle())
            .navigationBarTitle("メモ編集", displayMode: .inline)
        }
    }
}

