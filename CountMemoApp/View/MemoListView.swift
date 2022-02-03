import SwiftUI

struct MemoListView: View {

    @EnvironmentObject var store: MemoStore
    @State private var isShowAddMemoView = false
    @State private var isListTapped = false
    @State var editingMemo: Memo?

    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: AddMemoView().environmentObject(MemoStore()).onDisappear(perform: {
                    store.fetchMemos()
                }), isActive: $isShowAddMemoView) {
                    EmptyView()
                }
                List {
                    ForEach(store.memos, id: \.self) { memo in
                        NavigationLink(destination: EditMemoView(memo: memo).environmentObject(MemoStore()).onDisappear(perform: {
                            store.fetchMemos()
                        })) {
                            MemoListRow(memo: memo)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        store.deleteMemo(with: indexSet)
                    })
                }
                .navigationBarTitle("Memo List", displayMode: .large)
                FloatingButton(tapped: {
                    isShowAddMemoView.toggle()
                })
            }
        }
        .onAppear(perform: {
            store.fetchMemos()
        })
    }
}

struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
    }
}
