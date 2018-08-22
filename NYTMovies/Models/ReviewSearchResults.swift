//
//  ReviewSearchResults.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

public struct ReviewSearchResults: Codable {
    public let status: String
    public let copyright: String
    public let hasMore: Bool
    public let numResults: Int
    public let reviews: [Review]
    
    enum CodingKeys: String, CodingKey
    {
        case status
        case copyright
        case hasMore = "has_more"
        case numResults = "num_results"
        case reviews = "results"
    }
}

