//
//  File.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

struct Critic: Codable {
    let displayName: String
    let sortName: String
    let status: String
    let bio: String
    let seoName: String
    let multimedia: Multimedia?
    
    enum CodingKeys: String, CodingKey
    {
        case displayName = "display_name"
        case sortName = "sort_name"
        case status
        case bio
        case seoName = "seo_name"
        case multimedia
    }
}

