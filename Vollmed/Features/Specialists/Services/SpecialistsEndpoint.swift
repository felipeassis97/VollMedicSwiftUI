//
//  HomeEndpoint.swift
//  Vollmed
//
//  Created by Felipe Assis on 12/01/24.
//

import Foundation


enum SpecialistsEndpoint {
    case getAllSpecialists
}

extension SpecialistsEndpoint: Endpoint {
    var schema: String {
        return "http"
    }
    
    var path: String {
        switch self {
        case .getAllSpecialists:
            return "/especialista"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAllSpecialists:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getAllSpecialists:
            return nil
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .getAllSpecialists:
            return nil
        }
    }
}
