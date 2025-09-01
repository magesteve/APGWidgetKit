//
//  APGWidgetSlideShow.swift
//  APGWidgetKit
//
//  Created by Steve Sheets on 8/29/25.
//
//  Displays a slideshow of views with right-corner arrow to cycle them.
//

// MARK: - Imports

import SwiftUI

// MARK: - View

/// A SwiftUI view that cycles through an array of views with slide animation.
public struct APGWidgetSlideShow<Content: View>: View {

    // MARK: - Properties

    private let views: [Content]

    @State private var currentIndex: Int = 0
    @State private var transitionForward: Bool = true

    // MARK: - Init

    public init(views: [Content]) {
        self.views = views
    }

    // MARK: - Body

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                // View transition stack
                ZStack {
                    ForEach(views.indices, id: \.self) { index in
                        if index == currentIndex {
                            views[index]
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .transition(transitionForward ? .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)) : .asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                        }
                    }
                }
                .animation(.easeInOut(duration: 0.4), value: currentIndex)

                // Arrow button
                Button(action: {
                    let next = (currentIndex + 1) % views.count
                    transitionForward = true
                    currentIndex = next
                }) {
                    Image(systemName: APGWidget.arrow)
                        .font(.system(size: 32))
                        .foregroundColor(.accentColor)
                        .padding()
                        .background(Color.clear)
                }
                .buttonStyle(.plain)
            }
        }
    }
}
