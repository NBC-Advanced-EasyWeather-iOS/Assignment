//
//  ColorLiterals.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

//
//  ColorLiterals.swift
//  EasyWeather-iOS
//
//  Created by Joon Baek on 2024/02/07.
//

import UIKit

extension UIColor {
    
    // MARK: - Theme Colors
    
    static var darkTheme: UIColor {
        return UIColor(hex: "#4E628B")
    }
    
    static var normalTheme: UIColor {
        return UIColor(hex: "#D1DAEC")
    }
    
    static var lightTheme: UIColor {
        return UIColor(hex: "#F2F2F7")
    }
    
    static var mainTheme: UIColor {
        return UIColor(hex: "#007AFF")
    }

    // MARK: - Label Colors
    
    static var primaryLabel: UIColor {
        return UIColor(hex: "#000000")
    }
    
    static var secondaryLabel: UIColor {
        return UIColor(hex: "#3C3C43")
    }
    
    static var tertiaryLabel: UIColor {
        return UIColor(hex: "#3C3C43")
    }
    
    // MARK: - Background Colors
    
    static var primaryBackground: UIColor {
        return UIColor(hex: "#FFFFFF")
    }
    
    static var secondaryBackground: UIColor {
        return UIColor(hex: "#F2F2F7")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
