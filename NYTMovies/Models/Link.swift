//
//  Link.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

public struct Link: Codable {
    public let type: String
    public let url: String
    public let suggestedLinkText: String
    
    enum CodingKeys: String, CodingKey
    {
        case type
        case url
        case suggestedLinkText = "suggested_link_text"
    }
}
