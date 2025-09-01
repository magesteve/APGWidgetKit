//
//  APGWidgetUIRichTextView.swift
//  APGWidgetKit
//
//  Created by Steve Sheets on 9/1/25.
//
//  SwiftUI wrapper for APGWidgetRichTextView
//

// MARK: - Imports

import SwiftUI

// MARK: - View

/// A SwiftUI wrapper view for the APGWidgetRichTextView (macOS only).
public struct APGWidgetUIRichTextView: NSViewRepresentable {

    // MARK: - Typealias

    public typealias NSViewType = APGWidgetRichTextView

    // MARK: - Properties

    public var attributedText: AttributedString

    // MARK: - Init

    public init(attributedText: AttributedString) {
        self.attributedText = attributedText
    }

    // MARK: - NSViewRepresentable

    public func makeNSView(context: Context) -> NSViewType {
        let view = APGWidgetRichTextView()
        view.setAttributedText(attributedText)
        return view
    }

    public func updateNSView(_ nsView: NSViewType, context: Context) {
        nsView.setAttributedText(attributedText)
    }
}





