//
//  File.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

public struct Critic: Codable {
    public let displayName: String
    public let sortName: String
    public let status: String?
    public let bio: String?
    public let seoName: String
    public let multimedia: Multimedia?
    
    enum CodingKeys: String, CodingKey
    {
        case displayName = "display_name"
        case sortName = "sort_name"
        case status
        case bio
        case seoName = "seo_name"
        case multimedia
        case resource
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        /**
         Only critic responses have an nested multimedia object like such, need to strip away resource
         
         "multimedia": {
             "resource": {
                 "type": "image",
                 "src": "http://nytimes.com/images/2007/01/05/movies/sholden.163.jpg",
                 "height": 163,
                 "width": 220,
                 "credit": "Brent Murray/<br>NYTimes.com"
             }
         }
         */
        
        let resourceMedia = try container.decodeIfPresent(ResourceMultimedia.self, forKey: .multimedia)
        if let resource = resourceMedia {
            multimedia = resource.multimedia
        }
        else {
            multimedia = nil
        }
        
        displayName = try container.decode(String.self, forKey: .displayName)
        sortName = try container.decode(String.self, forKey: .sortName)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        seoName = try container.decode(String.self, forKey: .seoName)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(displayName, forKey: .displayName)
        try container.encode(sortName, forKey: .sortName)
        try container.encode(status, forKey: .status)
        try container.encode(bio, forKey: .bio)
        try container.encode(seoName, forKey: .seoName)
        try container.encode(multimedia, forKey: .multimedia)
        
    }
}

