import SwiftUI
import RealmSwift
import Combine

struct AddMemoView: View {

    @EnvironmentObject var store: MemoStore
    @ObservedObject var viewModel = MemoViewModel()

    @State private var content = ""
    @State private var title = ""
    @State private var computedValue = "0"
    @State private var isEditing = false
    @State private var isShowAlert = false
    @Environment(\.presentationMode) var presentation

    var body: some View {
        VStack {
            HStack {
                Text(computedValue)
                    .fontWeight(.bold)
                    .font(.title)
                Spacer()
                Button( action: {
                    self.computedValue = viewModel.extractValue(text: self.content)
                }) { Text("Compute")
                        .fontWeight(.semibold)
                        .frame(width: 100, height: 44)
                        .foregroundColor(Color.blue)
                        .background(Color(.white))
                        .cornerRadius(11)
                        .overlay(
                            RoundedRectangle(cornerRadius: 11)
                                .stroke(Color.blue, lineWidth: 1.0)
                        )
                }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            TextField("Title(nullable)", text: $title, onEditingChanged: { isEditing in
                self.isEditing = isEditing
            }, onCommit: {
                self.title = title
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .shadow(color: isEditing ? .blue : .clear, radius: 3)
            TextView(text: $content, onCommit: {
                self.content = content
            })
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            .navigationBarTitle("New Memo", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.isShowAlert.toggle()
                }) { Text("Save") }
                    .alert(isPresented: $isShowAlert) {
                        Alert(
                            title: Text("注意"),
                            message: Text("メモを保存しますか？"),
                            primaryButton: .default(Text("OK"), action: {
                                let memo = Memo.init(id: UUID().uuidString,
                                                     title: self.title.isEmpty ? "タイトルなしのメモ" : self.title,
                                                     content: self.content,
                                                     computedValue: self.computedValue,
                                                     registrationDate: viewModel.toStringRegistrationDate()
                                )
                                // 追加処理をする
                                store.addMemo(memo: memo)
                                self.presentation.wrappedValue.dismiss()
                            }),
                            secondaryButton: .destructive(Text("キャンセル"))
                        )
                    }
            )
        }
        .onTapGesture { UIApplication.shared.closeKeyboard() }
    }
}
