//
//  HTTPClient.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation


protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T?, RequestError>
}


struct HTTPClientImpl: HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T?, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.schema
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.port = 3000
        
        guard let url = urlComponents.url else {
            print("Error when build URL")
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let header = endpoint.header {
            request.allHTTPHeaderFields = header
        }
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                print("Error no response")
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard responseModel != nil else {
                    return .success(nil)
                }
                
                guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    print("Decode data error")
                    return .failure(.decode)
                }
                return .success(decodedResponse)
                
            case 400:
                let errorResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                print("Status code 400: \(String(describing: errorResponse))")
                return .failure(.custom(errorResponse))
                
            case 401:
                print("Status code 401")
                return .failure(.unauthorized)
                
            default:
                print("Status code unknown: \(String(describing: response.statusCode))")
                return .failure(.unknown)
            }
        }
        catch {
            print("Error unknown")
            return .failure(.unknown)
        }
    }
}
