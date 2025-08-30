# APGWidgetKit

A Swift package of handy windows, views, and small “widgets” that can drop into any app.
While **APGWidgetKit** is designed to be cross-platform, the **current** implementations primarily target **macOS (AppKit)**.

Repository https://github.com/magesteve/APGWidgetKit with current version **0.1.4**


## Highlights

- **APGWidgetWindow** — one-liners to present SwiftUI content in AppKit windows, modal alerts, and sheets (with lightweight window tracking by identifier).
- **APGWidgetRichTextView** — an AppKit `NSView` hosting a scrollable `NSTextView` for displaying Swift `AttributedString` content with sensible defaults.
- **APGWidgetLargeButton** — a SwiftUI View displaying oversided button commonly used in Work style windows.
- **APGWidgetStackedImageView** — a SwiftUI View that layers up to `five images` in a spread formation.

> The code uses `#if canImport(AppKit)` to keep the package cross-platform friendly. On non-macOS platforms these APIs are currently no-ops/placeholders.

---

## Installation (Swift Package Manager)

### Xcode
1. **File → Add Packages…**
2. Enter the repo URL: `https://github.com/magesteve/APGWidgetKit`
3. Choose **Up to Next Major** (recommended) and add the package.
4. Add the products you need (e.g., `APGWidgetKit`, `APGWidgetKit`) to your targets.

### Package.swift
```swift
// In your Package.swift dependencies:
.package(url: "https://github.com/magesteve/APGWidgetKit", from: "0.5.0"),
```

```swift
// In your target dependencies:
.target(
    name: "YourApp",
    dependencies: [
        .product(name: "APGWidgetKit", package: "APGWidgetKit"),
        .product(name: "APGWidgetKit", package: "APGWidgetKit")
    ]
)
```

---

## Usage

### APGWidgetWindow

A static utility (annotated `@MainActor`) that hosts SwiftUI views in AppKit containers. Window lifecycle is tracked by a caller-supplied **identifier** (`ident`) so repeated calls can focus an existing window instead of spawning duplicates.

#### Make a standard window
```swift
import SwiftUI
import APGWidgetKit

struct DemoPanel: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Hello from APGWidgetKit").font(.title2)
            Text("SwiftUI inside an AppKit window.")
        }
        .padding()
    }
}

func showDemoWindow() {
    APGWidgetWindow.makeWindow(
        title: "Demo",
        ident: "com.example.demo",
        size: CGSize(width: 420, height: 260)
    ) {
        DemoPanel()
    }
}
```

#### Bring an existing window to front (or close it)
```swift
// Focus if open:
APGWidgetWindow.makeWindow(
    title: "Demo",
    ident: "com.example.demo",
    size: CGSize(width: 420, height: 260)
) { DemoPanel() }

// Close later:
APGWidgetWindow.CloseWindow(ident: "com.example.demo")
```

#### Modal alert with an OK button
```swift
APGWidgetWindow.makeAlert {
    VStack(alignment: .leading, spacing: 12) {
        Text("Operation Complete").font(.headline)
        Text("Your export finished successfully.")
    }
}
```

#### Sheet attached to an existing `NSWindow`
```swift
// `hostWindow` is the owning NSWindow (e.g., from your NSWindowController)
APGWidgetWindow.makeAlertSheet(window: hostWindow) {
    VStack(spacing: 12) {
        Text("Options").font(.headline)
        Toggle("Enable Feature X", isOn: .constant(true))
        Button("Close") { hostWindow.endSheet(hostWindow.attachedSheet!) }
            .keyboardShortcut(.cancelAction)
    }
}
```

> **Notes**
> - `makeAlert` runs a modal loop (`NSApp.runModal`), hides the close button, and offers a default “OK” action.
> - `makeAlertSheet` presents a non-blocking sheet. You control dismissal via `window.endSheet(...)`.
> - `makeWindow` tracks windows by `ident` and removes them from the cache on `NSWindow.willClose`.

---

### APGWidgetLargeButton

A capsule-shaped SwiftUI button for **welcome panels, prompts, and onboarding**.
Supports optional default styling with accent color and keyboard shortcuts.

### Example
```swift
APGWidgetLargeButton(title: "Continue", isDefault: true) {
    print("Continue pressed")
}
APGWidgetLargeButton(title: "Cancel") {
    print("Cancel pressed")
}
```

- **title**: Button label text.
- **isDefault**: If true, accent color + default keyboard shortcut.
- **action**: Closure executed when pressed.

---

### APGWidgetStackedImageView

A **stacked image display view** that layers up to five images in a spread formation.  
Useful for **title screens, icon previews, or themed compositions**.  
If no images are provided, it attempts to display the **AppIcon** (from your asset catalog), and falls back to a system symbol.

### Example
```swift
import SwiftUI
import APGWidgetKit

struct DemoView: View {
    var body: some View {
        VStack {
            APGWidgetStackedImageView(imageNames: [
                "BackgroundImage",
                "Overlay1",
                "Overlay2"
            ])

            APGWidgetStackedImageView(imageNames: [])
            // Shows AppIcon (or fallback) when no names are given
        }
    }
}
```

### Behavior
- Supports **up to 5 images**, layered with horizontal offsets for a spread effect.
- Different **sizes per layer** for visual depth (largest at back, smaller at front).
- Each image has a subtle shadow for emphasis.
- If no images are given:
  - Displays `AppIcon` from assets if available.
  - Falls back to a system symbol (`app.fill`) otherwise.

### API
```swift
public struct APGWidgetStackedImageView: View {
    public init(imageNames: [String])
}
```

- **imageNames**: Array of image asset names (only the first 5 are used).

---

### APGWidgetRichTextView

A self-contained `NSView` with a scrollable, selectable `NSTextView` configured for **read-only** display of Swift `AttributedString`.

```swift
import AppKit
import APGWidgetKit

final class RichTextViewController: NSViewController {
    private let rich = APGWidgetRichTextView(frame: .zero)

    override func loadView() {
        self.view = rich
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var str = AttributedString("APGWidgetKit\n")
        str.font = .systemFont(ofSize: 18, weight: .semibold)

        var body = AttributedString("A handy scrollable view for AttributedString.\n")
        body.font = .systemFont(ofSize: 13)

        rich.setAttributedText(str + body)
    }
}
```

**Behavior & defaults**
- Non-editable, selectable text
- Transparent text background inside a scroll view
- Insets (`16x16`), zero line fragment padding, vertical resize enabled
- Width tracks container (good for auto-layout & window resizing)

If you need this inside SwiftUI, you can wrap it with `NSViewRepresentable`.

---

### Sample Code

The APGExample can be found at [Repository](https://github.com/magesteve/APGExample).

---

## License

[MIT License](LICENSE)
Created by **Steve Sheets**, 2025
