//
//  APGWidgetIconButton.swift
//  APGWidgetKit
//
//  Created by Steve Sheets on 8/29/25.
//
//  A stylized button that displays an SF Symbol and a text label.
//  Used in control panels to represent selectable options like tools or sections.
//

import SwiftUI

/// A reusable icon-style button with a title and symbol, visually styled for selection.
public struct APGWidgetIconButton: View {
    
    // MARK: - Parameters
    
    /// Title shown below the symbol.
    public let title: String
    
    /// SF Symbol name to display.
    public let symbolName: String
    
    /// Whether this button is currently selected.
    public let isSelected: Bool
    
    /// Action to perform when tapped.
    public let action: () -> Void
    
    // MARK: - Init
    
    /// Initializer
    public init(title: String,
         symbolName: String,
         isSelected: Bool,
         action: @escaping () -> Void) {
        self.title = title
        self.symbolName = symbolName
        self.isSelected = isSelected
        self.action = action
    }

    // MARK: - View
    
    public var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: symbolName)
                    .font(.title)
                Text(title)
                    .font(.caption2)
            }
            .padding(6)
            .frame(minWidth: 60)
            .background(isSelected ? Color.accentColor.opacity(0.2) : Color.clear)
            .cornerRadius(6)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
