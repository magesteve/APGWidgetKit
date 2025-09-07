# APGWidgetKit

**APGWidgetKit** is a Swift package of handy windows, views, and small widgets you can drop into any app.  
While designed to be **cross-platform**, the current focus is on **macOS (AppKit)**.

📦 Repository: [github.com/magesteve/APGWidgetKit](https://github.com/magesteve/APGWidgetKit)  
🔖 Current version: **0.2.0**

---

## Features

- **APGWidgetWindow** — simple one-liners to present SwiftUI content in AppKit windows, modal alerts, and sheets. Tracks windows by identifier.
- **APGWidgetRichTextView** — a scrollable, read-only AppKit `NSTextView` for Swift `AttributedString`.
- **APGWidgetUIRichTextView** — SwiftUI wrapper for `APGWidgetRichTextView`.
- **APGWidgetLargeButton** — a capsule-shaped SwiftUI button for welcome and prompt windows.
- **APGWidgetStackedImageView** — displays up to five layered images in a stacked formation.
- **APGWidgetIconButton** — an SF Symbol + text button styled for selection, commonly used in control panels.
- **APGWidgetSlideShow** — cycles through multiple SwiftUI views with a right-corner arrow and smooth slide animations.

> Uses `#if canImport(AppKit)` to remain cross-platform friendly. On non-macOS platforms these APIs compile as no-ops/placeholders.

---

## Installation (Swift Package Manager)

### In Xcode
1. Go to **File → Add Packages…**
2. Enter the URL:  
   ```
   https://github.com/magesteve/APGWidgetKit
   ```
3. Select **Up to Next Major**.
4. Add `APGWidgetKit` to your targets.

### In Package.swift
```swift
dependencies: [
    .package(url: "https://github.com/magesteve/APGWidgetKit", from: "0.1.5")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "APGWidgetKit", package: "APGWidgetKit")
        ]
    )
]
```

---

## Usage

### APGWidgetWindow

Create windows, alerts, and sheets directly from SwiftUI views.

```swift
APGWidgetWindow.makeWindow(
    title: "Demo",
    ident: "com.example.demo",
    size: CGSize(width: 420, height: 260)
) {
    VStack(spacing: 12) {
        Text("Hello from APGWidgetKit").font(.title2)
        Text("SwiftUI inside an AppKit window.")
    }
    .padding()
}
```

```swift
// Close an existing window
APGWidgetWindow.CloseWindow(ident: "com.example.demo")

// Show a modal alert
APGWidgetWindow.makeAlert {
    Text("Operation Complete").font(.headline)
}
```

---

### APGWidgetLargeButton

A capsule-shaped button for onboarding and prompts.

```swift
APGWidgetLargeButton(title: "Continue", isDefault: true) {
    print("Continue pressed")
}

APGWidgetLargeButton(title: "Cancel") {
    print("Cancel pressed")
}
```

---

### APGWidgetStackedImageView

Displays up to 5 images in a layered, spread-out stack.

```swift
APGWidgetStackedImageView(imageNames: [
    "BackgroundImage", "Overlay1", "Overlay2"
])

APGWidgetStackedImageView(imageNames: [])
// Shows AppIcon (or empty) if no names are given
```

---

### APGWidgetIconButton

A symbol + text button styled for panel/tool selection.

```swift
APGWidgetIconButton(
    title: "Settings",
    symbolName: "gear",
    isSelected: true
) {
    print("Settings tapped")
}
```

---

### APGWidgetSlideShow

Cycle through multiple SwiftUI views with an arrow button.

```swift
APGWidgetSlideShow(views: [
    AnyView(Text("Page 1")),
    AnyView(Text("Page 2")),
    AnyView(Text("Page 3"))
])
```

---

### APGWidgetRichTextView / APGWidgetUIRichTextView

Scrollable, read-only `NSTextView` for `AttributedString` (AppKit), plus SwiftUI wrapper.

```swift
// SwiftUI
APGWidgetUIRichTextView(
    attributedText: AttributedString("Hello Rich Text")
)
```

---

## Example Project
See [APGExample](https://github.com/magesteve/APGExample) for sample usage.

---

## License
MIT License — see [LICENSE](LICENSE)  
Created by **Steve Sheets**, 2025
