import SwiftUI

struct EditMemoView: View {

    @EnvironmentObject var store: MemoStore
    @ObservedObject var viewModel = MemoViewModel()
    var memo: Memo
    @State private var id = ""
    @State private var title = ""
    @State private var content = ""
    @State private var computedValue = ""
    @State private var registrationDate = ""
    @State private var isEditing = false
    @State private var isShowAlert = false
    @Environment(\.presentationMode) var presentation

    var body: some View {
        NavigationView {
            VStack {
                TextField("", text: $title,
                onEditingChanged: { isEditing in
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
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                BottomBorder(width: 1)
                    .foregroundColor(.gray)
                HStack {
                    Text(computedValue)
                        .fontWeight(.bold)
                        .font(.title)
                    Spacer()
                    Button( action: {
                        self.computedValue = viewModel.extractValue(text: content)
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
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                .navigationBarTitle("Edit Memo", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        self.isShowAlert.toggle()
                    }) { Text("Save") }
                        .alert(isPresented: $isShowAlert) {
                            Alert(
                                title: Text("注意"),
                                message: Text("メモを更新しますか？"),
                                primaryButton: .default(Text("OK"), action: {
                                    let memo = Memo.init(id: self.id,
                                                         title: self.title,
                                                         content: self.content,
                                                         computedValue: self.computedValue,
                                                         registrationDate: self.registrationDate
                                    )
                                    // 更新処理をする
                                    store.updateMemo(memo: memo)
                                    self.presentation.wrappedValue.dismiss()
                                }),
                                secondaryButton: .destructive(Text("キャンセル"))
                            )
                        }
                )
            }
        }
        .onAppear(perform: {
            self.id = memo.id
            self.title = memo.title ?? "タイトルなしのメモ"
            self.content = memo.content
            self.computedValue = memo.computedValue ?? "0"
            self.registrationDate = memo.registrationDate
        })
        .onTapGesture { UIApplication.shared.closeKeyboard() }
    }
}
