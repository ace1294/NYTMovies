//
//  ReviewSearchResults.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

struct ReviewSearchResults: Codable {
    let status: String
    let copyright: String
    let hasMore: Bool
    let numResults: Int
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey
    {
        case status
        case copyright
        case hasMore = "has_more"
        case numResults = "num_results"
        case reviews = "results"
    }
}

