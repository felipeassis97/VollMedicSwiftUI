//
//  WebService.swift
//  Vollmed
//
//  Created by Felipe Assis on 09/01/24.
//

import UIKit

struct WebService {
    
    private let baseURL = "http://localhost:3000"
    
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
            return UIImage(named: "Logo") ?? nil
        }
    }
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let endpoint = baseURL + "/especialista"
        guard let url = URL(string: endpoint) else { return nil }
        do {
            let (data, _) =  try await URLSession.shared.data(from: url)
            let specialists = try JSONDecoder().decode([Specialist].self, from: data)
            return specialists
        } catch {
            return nil
        }
    }
}
