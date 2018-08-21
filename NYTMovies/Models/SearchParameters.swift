//
//  SearchParameters.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

struct SearchParameters: Codable {
    let resourceType: String = "all.json"
    let offset: Int = 20
    let order: String = "by-title"
    let query: String?
    
    enum CodingKeys: String, CodingKey
    {
        case resourceType = "resource-type"
        case offset
        case order
        case query
    }
}
