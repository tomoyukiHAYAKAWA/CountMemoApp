import SwiftUI

struct MemoListView: View {
    
    @ObservedObject var viewModel = MemoListViewModel()
    @State private var showingAddMemoView = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AddMemoView(),
                               isActive: self.$showingAddMemoView) { EmptyView() }
                List (viewModel.memos) { memo in
                    NavigationLink(destination: EditMemoView(memo: memo)) {
                        MemoListRow(memo: memo)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("🗒", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: { self.showingAddMemoView = true }) { Text("✍️") }
                )
            }
        }
    }
}

struct MemoListRow: View {
    
    var memo: Memo
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10, content: {
                let title = memo.title ?? "タイトルなし"

                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                HStack(alignment: .bottom, spacing: 3, content:  {
                    let sumCount = memo.sumCount ?? "なし"
                    Text("カウント: \(String(sumCount))")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                    Spacer()
                    Text("作成日: \(memo.registrationDate!)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                })
            })
                .padding()
            LeftBorder(width: 4)
                .foregroundColor(.blue)
        }
    }
}

struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
    }
}
