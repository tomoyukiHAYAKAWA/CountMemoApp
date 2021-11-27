import SwiftUI

struct CreateMemoView: View {
    
    @State private var saveMemo = false
    
    var body: some View {
        VStack{
            TextView() { textView in
                textView.text = "タップで入力開始...！"
                textView.font = .systemFont(ofSize: 16)
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(maxWidth:.infinity, maxHeight: .infinity)
                .navigationBarTitle("✍️", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: { self.saveMemo = true }) { Text("👍") }
                )
        }
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
