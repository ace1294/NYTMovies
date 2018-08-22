//
//  CriticSearchResults.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

public struct CriticSearchResults: Codable {
    public let status: String
    public let copyright: String
    public let numResults: Int
    public let critics: [Critic]
    
    enum CodingKeys: String, CodingKey
    {
        case status
        case copyright
        case numResults = "num_results"
        case critics = "results"
    }
}
