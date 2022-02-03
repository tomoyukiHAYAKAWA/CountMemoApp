import SwiftUI

struct MemoListRow: View {

    var memo: Memo

    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10, content: {
                Text(memo.title)
                    .font(.title)
                    .fontWeight(.bold)
                HStack(alignment: .bottom, spacing: 3, content:  {
                    Text("Value: \(memo.computedValue)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                    Spacer()
                    Text("Created: \(memo.registrationDate)")
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
