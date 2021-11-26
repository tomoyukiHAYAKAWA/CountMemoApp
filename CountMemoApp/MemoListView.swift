import SwiftUI

struct MemoListView: View {
    
    @ObservedObject var viewModel = MemoListViewModel()
    
    var body: some View {
        NavigationView{
            List(viewModel.memos) { memo in
                MemoListRow(memo: memo)
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("メモ一覧", displayMode: .inline)
        }
    }
}

struct MemoListRow: View {
    
    var memo: Memo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5, content: {
                let title = memo.title ?? "タイトル🙅‍♂️のメモ"
                let sumCount = memo.sumCount ?? "なし🙅‍♂️"
                Text(title)
                Text("カウント: \(String(sumCount))")
            })
            .padding()
            let registrationDate = memo.registrationDate!
            Text(registrationDate)
        }
    }
}

struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
    }
}
