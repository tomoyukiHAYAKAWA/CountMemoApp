import Foundation

struct Memo: Identifiable {
    var id = UUID()
    var title: String?
    var content: String!
    var sumCount: String?
    var registrationDate: String!
    
    init(title: String?, content: String, sumCount: String?, registrationDate: String) {
        self.title = title
        self.content = content
        self.sumCount = sumCount
        self.registrationDate = registrationDate
    }
}
