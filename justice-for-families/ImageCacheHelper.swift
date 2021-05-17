//
//  ImageCacheHelper.swift
//  justice-for-families
//
//  Created by Jules Labador on 5/16/21.
//

import Foundation
import UIKit

struct ImageCacheHelper {
    static let imagecache = NSCache<NSString, ImageCache>()
}


class ImageCache: NSObject, NSDiscardableContent {

    public var image: UIImage!

    func beginContentAccess() -> Bool {
        return true
    }

    func endContentAccess() {

    }

    func discardContentIfPossible() {

    }

    func isContentDiscarded() -> Bool {
        return false
    }
}

