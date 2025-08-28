//
//  APGWidgetWindow.swift
//  APGWidgetKit
//
//  Created by Steve Sheets on 8/25/25.
//

// MARK: - Import

import Foundation

#if canImport(AppKit)

import AppKit

#endif

#if canImport(SwiftUI)

import SwiftUI

#endif

// MARK: - Class

/// Static class providing tools to display WIndows with SwiftUI content.
@MainActor
public final class APGWidgetWindow {
    
#if canImport(AppKit)

// MARK: - AppKit Window Tracking
    
    /// List of windows for internal tracking
    private static var activeWindows: [String: NSWindow] = [:]
    
#endif

    /// Given ident, close associated window.
    ///     Currently on support AppKit
    public static func CloseWindow(ident: String) {

#if canImport(AppKit)

        if let window = activeWindows[ident] {
            window.close()
            activeWindows.removeValue(forKey: ident)
        }

#endif

    }
    

#if canImport(SwiftUI)
    
    // MARK: - Public Alert Windows
    
    /// Make an alert displaying SwiftUI view and OK button
    ///     Currently on support AppKit
    public static func makeAlert(size: NSSize? = nil,
                                 viewMaker: @escaping () -> some View) {
#if canImport(AppKit)

        let contentView = NSHostingView(rootView:
                                            VStack {
            viewMaker()
            Divider()
            Button("OK") {
                NSApp.stopModal()
            }
            .keyboardShortcut(.defaultAction)
            .padding(.top, 8)
        }
            .padding()
        )
        
        let window = NSWindow()
        window.contentView = contentView
        window.styleMask = [.titled]
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.standardWindowButton(.closeButton)?.isHidden = true
        window.level = .modalPanel
        window.isReleasedWhenClosed = false
        window.center()
        
        if let customSize = size {
            window.setContentSize(customSize)
        } else {
            contentView.layoutSubtreeIfNeeded()
            window.setContentSize(contentView.fittingSize)
        }
        
        NSApp.runModal(for: window)
        window.close()
        
#endif
        
    }
    
    /// Make a window sheet displaying SwiftUI view
    ///     Currently on support AppKit
    public static func makeAlertSheet(window: NSWindow,
                                       size: NSSize? = nil,
                                       viewMaker: @escaping () -> some View) {
        
#if canImport(AppKit)

        let hostingView = NSHostingView(rootView:
                                            VStack { viewMaker() }
            .padding()
        )
        
        let sheetWindow = NSWindow()
        sheetWindow.contentView = hostingView
        sheetWindow.styleMask = [.titled]
        sheetWindow.titleVisibility = .hidden
        sheetWindow.titlebarAppearsTransparent = true
        sheetWindow.standardWindowButton(.closeButton)?.isHidden = true
        sheetWindow.isReleasedWhenClosed = false
        sheetWindow.center()
        
        if let customSize = size {
            sheetWindow.setContentSize(customSize)
        } else {
            hostingView.layoutSubtreeIfNeeded()
            sheetWindow.setContentSize(hostingView.fittingSize)
        }
        
        window.beginSheet(sheetWindow)

#endif

    }
    
    // MARK: - Public Window Creation
    
    /// Make window displaying SwiftUI views.
    ///     Currently on support AppKit
    public static func makeWindow(title: String,
                                  ident: String,
                                  size: CGSize,
                                  viewMaker: @escaping () -> some View) {

#if canImport(AppKit)

        if let existingWindow = activeWindows[ident] {
            existingWindow.makeKeyAndOrderFront(nil)
            return
        }
        
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: size.width, height: size.height),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        
        
        window.title = title
        if title.isEmpty {
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
        }
        window.contentView = NSHostingView(rootView: viewMaker())
        window.center()
        window.makeKeyAndOrderFront(nil)
        window.isReleasedWhenClosed = false
        
        // Track and clean up
        activeWindows[ident] = window
        
        let _ = NotificationCenter.default.addObserver(
            forName: NSWindow.willCloseNotification,
            object: window,
            queue: nil
        ) { _ in
            Task { @MainActor in
                activeWindows.removeValue(forKey: ident)
            }
        }

#endif

    }

#endif
    
}

