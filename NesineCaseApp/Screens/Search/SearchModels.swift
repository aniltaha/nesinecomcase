//
//  SearchModels.swift
//  NesineCaseApp
//
//  Created by Anıl Taha Uyar on 9.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum SearchModel {
    
    struct Response: Codable {
        var resultCount: Int?
        var results: [ResultModel]?
    }
    
    struct ResultModel: Codable {
        var screenshotUrls: [String]?
    }
    
    struct ImageModel {
        var smallSizeSection: [UIImage]
        var largeSizeSection: [UIImage]
        var xLargeSizeSection: [UIImage]
        var xxLargeSizeSection: [UIImage]
    }
    
    enum ImageSizeType: Int {
        case SMALL_SIZE = 100000
        case LARGE_SIZE = 250000
        case XLARGE_SIZE = 500000
        case XXLARGE_SIZE = 501000
    }
    
    enum Sections {
        case FIRST
        case SECOND
        case THIRD
        case FOURTH
        case DEFAULT
    }
}
