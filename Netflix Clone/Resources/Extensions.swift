//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-17.
//

import Foundation

extension String {
    func capitalizedFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
     }
}
