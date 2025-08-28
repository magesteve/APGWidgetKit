//
//  APGWidgetStackedImageView.swift
//  APGWidgetKit
//
//  Created by Steve Sheets on 8/27/25.
//
//  Displays up to 5 layered images in a stacked formation.
//  If no images are provided, displays the app icon.
//

import AppKit
import SwiftUI
import Combine

/// A view that displays up to five images layered visually in a stack.
///
/// This component is useful for title screens, icon previews, or themed visual
/// compositions. If no images are provided, the app icon is shown instead.
public struct APGWidgetStackedImageView: View {

    // MARK: - Properties

    /// The list of image names to display (maximum of 5).
    public let imageNames: [String]

    // MARK: - Initialization

    /// Initialize with a list of image names to layer.
    /// - Parameter imageNames: An array of String instances.
    public init(imageNames: [String]) {
        self.imageNames = imageNames
    }

    // MARK: - View

    public var body: some View {
        ZStack {
            if imageNames.isEmpty {
                // No images provided; render nothing (or add your own placeholder).
                EmptyView()
            } else {
                // Show layered stack of up to 5 images from the asset catalog
                ForEach(Array(imageNames.prefix(5).enumerated()), id: \.offset) { index, name in
                    Image(name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width(for: index), height: height(for: index))
                        .offset(x: offsetX(for: index))
                        .zIndex(Double(5 - index))
                        .shadow(radius: 6)
                }
            }
        }
        .frame(width: 420, height: 320)
    }

    // MARK: - Layout Helpers

    /// Determines width based on image index in stack.
    private func width(for index: Int) -> CGFloat {
        switch index {
        case 0: return 420
        case 1, 2: return 360
        default: return 300
        }
    }

    /// Determines height based on image index in stack.
    private func height(for index: Int) -> CGFloat {
        switch index {
        case 0: return 320
        case 1, 2: return 280
        default: return 240
        }
    }

    /// Determines horizontal offset to create spread effect.
    private func offsetX(for index: Int) -> CGFloat {
        switch index {
        case 1: return -140
        case 2: return 140
        case 3: return -220
        case 4: return 220
        default: return 0
        }
    }
}
