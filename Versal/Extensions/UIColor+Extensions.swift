//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation
import UIKit

extension UIColor {
    @nonobjc class var bgWhite: UIColor { UIColor(white: 246.0 / 255.0, alpha: 1.0) }
    @nonobjc class var blueyGrey: UIColor { UIColor(red: 137.0 / 255.0, green: 144.0 / 255.0, blue: 162.0 / 255.0, alpha: 1.0) }
    @nonobjc class var brownGrey: UIColor { UIColor(white: 153.0 / 255.0, alpha: 1.0) }
    @nonobjc class var cherryRed: UIColor { UIColor(red: 1.0, green: 0.0, blue: 43.0 / 255.0, alpha: 1.0) }
    @nonobjc class var deepSkyBlue: UIColor { UIColor(red: 10.0 / 255.0, green: 133.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0) }
    @nonobjc class var darkIndigo: UIColor { UIColor(red: 12.0 / 255.0, green: 24.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0) }
    @nonobjc class var tealish: UIColor { UIColor(red: 39.0 / 255.0, green: 210.0 / 255.0, blue: 165.0 / 255.0, alpha: 1.0) }
    @nonobjc class var tealishGreen: UIColor { UIColor(red: 15.0 / 255.0, green: 220.0 / 255.0, blue: 124.0 / 255.0, alpha: 1.0) }
    @nonobjc class var veryLightGrey: UIColor { UIColor(white: 184.0 / 255.0, alpha: 1.0) }
    @nonobjc class var veryLightPink: UIColor { UIColor(white: 213.0 / 255.0, alpha: 1.0) }
    @nonobjc class var veryLightPinkTwo: UIColor { UIColor(white: 201.0 / 255.0, alpha: 1.0) }
    @nonobjc class var veryLightPinkThree: UIColor { UIColor(white: 233.0 / 255.0, alpha: 1.0) }
    @nonobjc class var vibrantGreen: UIColor { UIColor(red: 10.0 / 255.0, green: 219.0 / 255.0, blue: 45.0 / 255.0, alpha: 1.0) }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }

    func rgb() -> (red: Int, green: Int, blue: Int, alpha: Int)? {
        var fRed: CGFloat = 0, fGreen: CGFloat = 0, fBlue: CGFloat = 0, fAlpha: CGFloat = 0

        guard getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) else {
            return nil
        }

        let iRed = Int(fRed * 255.0)
        let iGreen = Int(fGreen * 255.0)
        let iBlue = Int(fBlue * 255.0)
        let iAlpha = Int(fAlpha * 255.0)
        return (red: iRed, green: iGreen, blue: iBlue, alpha: iAlpha)
    }
}

class GradientColors {
    // MARK: Lifecycle
    init() {
        let colorTop = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        let colorBottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor

        self.topGradient = CAGradientLayer()
        topGradient.colors = [colorTop, colorBottom]
        topGradient.locations = [0.0, 0.3]

        self.bottomGradient = CAGradientLayer()
        bottomGradient.colors = [colorBottom, colorTop]
        bottomGradient.locations = [0.5, 1]
    }

    // MARK: Internal
    var topGradient: CAGradientLayer!
    var bottomGradient: CAGradientLayer!
}
