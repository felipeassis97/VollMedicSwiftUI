//
//  Date+.swift
//  Vollmed
//
//  Created by Felipe Assis on 09/01/24.
//

import Foundation

extension Date {
    func toString () -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: self)
    }
}
