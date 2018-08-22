//
//  Movie.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

public struct Review: Codable {
    public let displayTitle: String
    public let mpaaRating: String
    public let criticsPick: Int
    public let byLine: String
    public let headline: String
    public let summaryShort: String
    public let publicationDate: String
    public let openingDate: String?
    public let dateUpdated: String?
    public let link: Link
    public let multimedia: Multimedia?
    
    enum CodingKeys: String, CodingKey
    {
        case displayTitle = "display_title"
        case mpaaRating = "mpaa_rating"
        case criticsPick = "critics_pick"
        case byLine = "byline"
        case headline
        case summaryShort = "summary_short"
        case publicationDate = "publication_date"
        case openingDate = "opening_date"
        case dateUpdated = "date_updated"
        case link
        case multimedia
    }
}
