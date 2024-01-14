//
//  DownloadImageService.swift
//  Vollmed
//
//  Created by Felipe Assis on 14/01/24.
//

import Foundation
import UIKit

protocol DownloadImageServiciable {
    func dowloadImage(from imageURL: String) async throws -> UIImage?
}

struct DownloadImageService: DownloadImageServiciable {
    func dowloadImage(from imageURL: String) async throws -> UIImage? {
        
        let imageCache = NSCache<NSString, UIImage>()
        guard let url = URL(string: imageURL) else { return UIImage(named: "Logo") ?? nil }
        
        //Check if exists in cache
        if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
            return cachedImage
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image =  UIImage(data: data) else {
                return UIImage(named: "Logo") ?? nil
            }
            //Save in cache
            imageCache.setObject(image, forKey: imageURL as NSString)
            return image
        }
        catch {
            print("Error when download image: \(error)")
            return UIImage(named: "Logo") ?? nil
        }
    }
}
