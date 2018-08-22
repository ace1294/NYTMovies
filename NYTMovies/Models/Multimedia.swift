//
//  Multimedia.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

public struct Multimedia: Codable {
    public let type: String
    public let src: String
    public let width: Int
    public let height: Int
    public let credit: String?
}

public struct ResourceMultimedia: Codable {
    public let multimedia: Multimedia?
    enum CodingKeys: String, CodingKey {
        case multimedia = "resource"
    }
}
