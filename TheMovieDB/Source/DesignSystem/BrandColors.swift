//
//  BrandColors.swift
//  TheMovieDB
//
//  Created by jossehblanco on 21/3/24.
//

import SwiftUI

// MARK: - Older Xcode Support
enum BrandColor: String {
    case primary = "brandPrimary"
    case secondaryDark = "brandSecondaryDark"
    case secondaryLight = "brandSecondaryLight"
    case tertiary = "brandTertiary"
}

extension Color {
    init(brandColor: BrandColor) {
        self.init(brandColor.rawValue)
    }
}
