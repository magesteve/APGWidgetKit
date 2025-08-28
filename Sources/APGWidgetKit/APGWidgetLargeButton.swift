//
//  APGLargeButton.swift
//  APGWidgetKit
//
//  Created by Steve Sheets on 2025-05-16
//
//  Rev 1.0 on 2025-06-09
//
//  A SwiftUI capsule-shaped large button used in APG-style
//  welcome and prompt views. Supports optional default
//  styling and keyboard shortcuts.
//

// MARK: - Imports

import Foundation

#if canImport(SwiftUI)

import SwiftUI

// MARK: - Class

/// A stylized large button rendered in a capsule shape.
/// Useful for welcome panels, onboarding, or prominent choices.
public struct APGLargeButton: View {

    // MARK: - Properties

    /// Button title string.
    public let title: String

    /// Whether this button is the default action (changes color and shortcut).
    public let isDefault: Bool

    /// The action to perform when the button is tapped.
    public let action: () -> Void

    // MARK: - Init

    /// Initialize a large capsule-style button.
    /// - Parameters:
    ///   - title: The text to display.
    ///   - isDefault: If true, uses accent color and triggers default keyboard shortcut.
    ///   - action: Closure to execute when the button is pressed.
    public init(title: String, isDefault: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.isDefault = isDefault
        self.action = action
    }

    // MARK: - View

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(width: 200, height: 30)
                .background(
                    Capsule()
                        .fill(isDefault ? Color.accentColor : Color.gray.opacity(0.2))
                )
                .foregroundColor(isDefault ? .white : .primary)
                .contentShape(Capsule())
        }
        .buttonStyle(PlainButtonStyle())
        .keyboardShortcut(isDefault ? .defaultAction : .cancelAction)
        .accessibilityLabel(Text(title))
    }
}

#endif
