
import SwiftUI

/**
 These extensions enable using the custom Spacing enum inside the 'padding' view modifier
 and enables initializing a VStack or an HStack with custom Spacing.
 */

public extension View {
    func padding(_ edges: Edge.Set = .all, _ length: Spacing) -> some View {
        padding(edges, length.value)
    }
}

public extension VStack where Content: View {
    init(
        alignment: HorizontalAlignment = .center,
        spacing: Spacing = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            alignment: alignment,
            spacing: spacing.value,
            content: content
        )
    }
}

public extension HStack where Content: View {
    init(
        alignment: VerticalAlignment = .center,
        spacing: Spacing = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            alignment: alignment,
            spacing: spacing.value,
            content: content
        )
    }
}

public extension VStack where Content: View {
    init(@ViewBuilder content: () -> Content) {
        self.init(
            alignment: .center,
            spacing: nil,
            content: content
        )
    }
}

public extension HStack where Content: View {
    init(@ViewBuilder content: () -> Content) {
        self.init(
            alignment: .center,
            spacing: nil,
            content: content
        )
    }
}

public extension VStack where Content: View {
    init(alignment: HorizontalAlignment = .center, @ViewBuilder content: () -> Content) {
        self.init(
            alignment: .center,
            spacing: nil,
            content: content
        )
    }
}

public extension HStack where Content: View {
    init(alignment: VerticalAlignment = .center, @ViewBuilder content: () -> Content) {
        self.init(
            alignment: .center,
            spacing: nil,
            content: content
        )
    }
}
