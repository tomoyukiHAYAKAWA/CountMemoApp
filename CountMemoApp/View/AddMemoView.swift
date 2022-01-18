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
        NavigationView {
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
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
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
        }
        .onTapGesture { UIApplication.shared.closeKeyboard() }
    }
}

// 複数行入力するためのTextView
struct TextView: UIViewRepresentable {
    @Binding var text: String

    var onCommit: ()->()

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator
        view.font = UIFont.systemFont(ofSize: 18)
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ textView: TextView) {
            self.parent = textView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            parent.onCommit()
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
}
