import SwiftUI

struct LeftBorder: Shape {
    var width: CGFloat

    func path(in rect: CGRect) -> Path {
        Path( CGRect(
            x: rect.minX,
            y: rect.minY,
            width: self.width,
            height: rect.height
        ) )
    }
}

struct BottomBorder: Shape {
    var width: CGFloat

    func path(in rect: CGRect) -> Path {
        Path( CGRect(
            x: rect.minX,
            y: rect.maxY - width,
            width: rect.width,
            height: self.width
        ) )
    }
}
