//
//  CriticSearchResults.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

struct CriticSearchResults: Codable {
    let status: String
    let copyright: String
    let numResults: Int
    let critics: [Critic]
    
    enum CodingKeys: String, CodingKey
    {
        case status
        case copyright
        case numResults = "num_results"
        case critics = "results"
    }
}
