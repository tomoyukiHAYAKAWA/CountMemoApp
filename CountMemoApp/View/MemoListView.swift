import SwiftUI

struct MemoListView: View {

    @EnvironmentObject var store: MemoStore
    @State private var showSeetView = false
    @State private var isListTapped = false
    @State var editingMemo: Memo?

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(store.memos, id: \.self) { memo in
                        MemoListRow(memo: memo)
                            .onTapGesture {
                                isListTapped.toggle()
                                editingMemo = memo
                                print(memo)
                            }
                    }
                    .onDelete(perform: { indexSet in
                        store.deleteMemo(with: indexSet)
                    })
                    .sheet(item: $editingMemo, onDismiss: { store.fetchMemos() })
                    { memo in
                        EditMemoView(memo: memo).environmentObject(MemoStore())
                    }
                }
                .navigationBarTitle("Memo List")
                .sheet(isPresented: $showSeetView, onDismiss: { store.fetchMemos() },
                       content: {
                    AddMemoView().environmentObject(MemoStore()) }
                )
                FloatingButton(tapped: {
                    showSeetView.toggle()
                })
            }
        }
        .onAppear(perform: {
            store.fetchMemos()
        })
    }
}

struct FloatingButton: View {
    var tapped: ()->()
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.tapped()
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                })
                    .frame(width: 60, height: 60)
                    .background(Color.blue)
                    .cornerRadius(30.0)
                    .shadow(color: .gray, radius: 3, x: 3, y: 3)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))

            }
        }
    }
}

struct MemoListRow: View {
    
    var memo: Memo
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10, content: {
                Text(memo.title)
                    .font(.title)
                    .fontWeight(.bold)
                HStack(alignment: .bottom, spacing: 3, content:  {
                    Text("カウント: \(memo.computedValue)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                    Spacer()
                    Text("作成日: \(memo.registrationDate)")
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
