//
//  SearchParameters.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

public enum SortOrder: String, Codable {
    case title = "by-title"
    case publicationDate = "by-publication-date" // Comes chronological, opposite of documentation
    case openingDate = "by-opening-date" // Comes chronological, starting with null, opposite of documentation
}

// Not allowing the user to query against publication dates because it does not work
public struct ReviewSearchParameters: Encodable {
    
    public var offset: Int = 0 // Does not need to be multiple of 20
    public var order: SortOrder = .title
    public var query: String?
    public var reviewer: String?
    public var onlyCriticPicks: Bool = false
    public var openingStartDate: String?
    public var openingEndDate: String?
    
    enum CodingKeys: String, CodingKey
    {
        case offset
        case order
        case query
        case reviewer
        case openingDate = "opening-date"
    }
    
    public init() {}
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(offset, forKey: .offset)
        try container.encode(order, forKey: .order)
        
        if let queryString = query {
            guard let sluggedQuery = queryString.slugify() else {
                throw EncodingError.invalidValue(query as Any,
                                                 EncodingError.Context(codingPath: [], debugDescription: "Failed to slugify query string"))
            }
            try container.encode(sluggedQuery, forKey: .query)
        }
        
        
        if let reviewerString = reviewer {
            guard let sluggedReviewer = reviewerString.slugify() else {
                throw EncodingError.invalidValue(reviewer as Any,
                                                 EncodingError.Context(codingPath: [], debugDescription: "Failed to slugify reviewer string"))
            }
            try container.encode(sluggedReviewer, forKey: .reviewer)
        }
        
        
        var openingParams: String? = nil
        if let start = openingStartDate {
            if let end = openingEndDate {
                openingParams = "\(start);\(end)"
            }
            else {
                openingParams = start
            }
        }
        
        try container.encodeIfPresent(openingParams, forKey: .openingDate)
        
    }

}
