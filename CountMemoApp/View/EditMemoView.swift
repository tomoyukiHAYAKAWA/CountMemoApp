import SwiftUI

struct EditMemoView: View {

    @ObservedObject var viewModel = MemoViewModel()
    var memo: Memo
    @State private var content = ""
    @State private var title = ""
    @State private var sumCount = "0"
    @State private var isEditing = false

    var body: some View {
        VStack {
            TextField("", text: $title,
                onEditingChanged: { isEditing in
                    self.isEditing = isEditing
                },
                onCommit: {
                    self.title = title
                }
            )
                .onAppear() {
                    self.title = memo.title!
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .shadow(color: isEditing ? .blue : .clear, radius: 3)
            TextView(text: $content,
                onCommit: {
                    self.content = content
                }
            )
                .onAppear() {
                    self.content = memo.content
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            BottomBorder(width: 1)
                .foregroundColor(.gray)
            HStack {
                Text(sumCount)
                    .onAppear() {
                        self.sumCount = memo.sumCount ?? "0"
                    }
                Spacer()
                Button( action: {
                    self.sumCount = viewModel.extractValue(text: self.content)
                }) { Text("計算する")
                        .fontWeight(.semibold)
                        .frame(width: 100, height: 44)
                        .foregroundColor(Color.blue)
                        .background(Color(.white))
                        .cornerRadius(22)
                        .overlay(
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(Color.blue, lineWidth: 1.0)
                        )
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
            .navigationBarTitle("✍️", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    let memo = Memo()
                    memo.id = self.memo.id
                    memo.title = self.title
                    memo.content = self.content
                    memo.registrationDate = viewModel.toStringRegistrationDate()
                    memo.sumCount = self.sumCount
                    viewModel.update(memo: memo)
                }) { Text("👌") }
            )
        }
        .onTapGesture { UIApplication.shared.closeKeyboard() }
    }
}
