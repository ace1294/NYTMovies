//
//  String.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/22/18.
//  Copyright © 2018 Jason Dimitriou. All rights reserved.
//

import Foundation

extension String {
    private static let slugSafeCharacters = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-.")
    
    public func slugify() -> String? {
        if let latin = self.applyingTransform(StringTransform("Any-Latin; Latin-ASCII; Lower;"), reverse: false) {
            let urlComponents = latin.components(separatedBy: String.slugSafeCharacters.inverted)
            let result = urlComponents.filter { $0 != "" }.joined(separator: "%20")
            
            if result.count > 0 {
                return result
            }
        }
        
        return nil
    }
}
