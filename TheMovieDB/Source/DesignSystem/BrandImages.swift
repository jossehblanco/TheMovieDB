//
//  BrandImages.swift
//  TheMovieDB
//
//  Created by jossehblanco on 21/3/24.
//

import SwiftUI

// MARK: - Older Xcode Support
enum BrandImage: String {
    case logo = "brandLogo"
}

extension Image {
    init(brandImage: BrandImage) {
        self.init(brandImage.rawValue)
    }
}
