import SwiftUI

struct CreateMemoView: View {
    
    @State private var saveMemo = false
    @State private var isEditing = false
    @State private var title = ""
    
    var body: some View {
        VStack {
            TextField("タイトルを入力...!(なしでもOK👍)", text: $title,
                onEditingChanged: { isEditing in
                    self.isEditing = isEditing
                },
                onCommit: {
                    self.title = title
                }
            )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .shadow(color: isEditing ? .blue : .clear, radius: 3)
            TextView() { textView in
                textView.text = "タップで入力開始...！"
                textView.font = .systemFont(ofSize: 16)
            }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            BottomBorder(width: 1)
                .foregroundColor(.gray)
            HStack {
                Text("計算結果なし")
                Spacer()
                Button( action: {
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
                trailing: Button(action: { self.saveMemo = true }) { Text("👌") }
            )
        }
        .onTapGesture { UIApplication.shared.closeKeyboard() }
    }
}

struct TextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    var configuration = { (view: UIViewType) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIViewType {
        UIViewType()
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Self>) {
        configuration(uiView)
    }
}
