//
//  UIColor.swift
//  Spotify
//
//  Created by Melik Demiray on 16.12.2024.
//

import Foundation
import UIKit

extension UIColor {
    /// Creates a color from a hex string with optional alpha value
    /// - Parameters:
    ///   - hex: A hex color string (e.g., "#FF0000" or "FF0000")
    ///   - alpha: Optional alpha value between 0.0 and 1.0 (default is 1.0)
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        // Remove # if present and convert to uppercase
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
            .uppercased()

        // Ensure hex string is valid (6 or 8 characters)
        guard hexString.count == 6 || hexString.count == 8 else {
            return nil
        }

        // Separate color components
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        // Handle hex with 6 or 8 characters
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let finalAlpha: CGFloat

        if hexString.count == 6 {
            red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(rgbValue & 0x0000FF) / 255.0
            finalAlpha = alpha
        } else {
            // 8 character hex includes alpha
            red = CGFloat((rgbValue & 0xFF00_0000) >> 24) / 255.0
            green = CGFloat((rgbValue & 0x00FF_0000) >> 16) / 255.0
            blue = CGFloat((rgbValue & 0x0000_FF00) >> 8) / 255.0
            finalAlpha = CGFloat(rgbValue & 0x0000_00FF) / 255.0
        }

        self.init(red: red, green: green, blue: blue, alpha: finalAlpha)
    }
}
