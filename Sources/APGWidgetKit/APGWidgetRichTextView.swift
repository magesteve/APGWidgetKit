//
//  APGWidgetRichTextView.swift
//  APGWidgetKit
//
//  Created by Steve Sheets on 8/25/25.
//

// MARK: - Imports

import Foundation

#if canImport(AppKit)

import AppKit

// MARK: - Class

/// A self-contained view that displays an AttributedString in a scrollable text view.
public final class APGWidgetRichTextView: NSView {

    // MARK: - Private UI

    private let scrollView = NSScrollView()
    private let textView = NSTextView(frame: .zero)

    // MARK: - Init

    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupUI()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Public API

    /// Replace the displayed content with a Swift `AttributedString`.
    public func setAttributedText(_ text: AttributedString) {
        let ns = NSAttributedString(text)
        textView.textStorage?.setAttributedString(ns)
    }

    // MARK: - Private

    private func setupUI() {
        // Configure text view
        textView.isEditable = false
        textView.isSelectable = true
        textView.drawsBackground = false
        textView.textContainerInset = NSSize(width: 16, height: 16)
        textView.textContainer?.lineFragmentPadding = 0
        textView.isHorizontallyResizable = false
        textView.isVerticallyResizable = true
        textView.autoresizingMask = [.width]
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.textContainer?.containerSize = NSSize(width: 0, height: CGFloat.greatestFiniteMagnitude)
        textView.textContainer?.widthTracksTextView = true

        // Configure scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.borderType = .noBorder
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.drawsBackground = true
        scrollView.documentView = textView

        // Add + pin
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

#endif
