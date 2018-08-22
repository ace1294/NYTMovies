//
//  Encodable.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//  Copyright © 2018 Jason Dimitriou. All rights reserved.
//

import Foundation

extension Encodable {
    
    func queryString() throws -> String {
        do {
            let data = try JSONEncoder().encode(self)
            // Catches error if force unwrap fails
            let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>

            let queryString = (dict.map({ (key, value) -> String in
                return "\(key)=\(value)"
            }) as Array).joined(separator: "&")
            return queryString
        }
        catch {
            throw error
        }
    }
}
