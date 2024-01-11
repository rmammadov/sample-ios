//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation
import UIKit

enum JPEGQuality: CGFloat {
    case lowest = 0
    case low = 0.25
    case medium = 0.5
    case high = 0.75
    case highest = 1
}

extension UIImage {
    func getThumbnail() -> UIImage? {
        guard let imageData = pngData() else { return nil }

        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: 300
        ] as CFDictionary

        guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
        guard let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options) else { return nil }

        return UIImage(cgImage: imageReference)
    }

    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width + insets.left + insets.right,
                                                      height: size.height + insets.top + insets.bottom),
                                               false,
                                               scale)
        // let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }

    func jpeg(_ quality: JPEGQuality) -> UIImage? {
        guard let data = jpegData(compressionQuality: quality.rawValue),
              let image = UIImage(data: data)
        else { return nil }
        return image
    }
}

extension UIImageView {
    func setOverlay(withColor color: UIColor) {
        if let image = image?.withRenderingMode(.alwaysTemplate) {
            self.image = image
            tintColor = color
        }
    }
}
