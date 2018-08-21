//
//  Link.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

struct Link: Codable {
    let type: String
    let url: String
    let suggestedLinkText: String
    
    enum CodingKeys: String, CodingKey
    {
        case type
        case url
        case suggestedLinkText = "suggested_link_text"
    }
}
