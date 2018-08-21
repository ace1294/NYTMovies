//
//  Movie.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

struct Review: Codable {
    
    let displayTitle: String
    let mpaaRating: String
    let criticsPick: Int
    let byLine: String
    let headline: String
    let summaryShort: String
    let publicationDate: String
    let openingDate: String
    let dateUpdated: String
    let link: Link
    let multimediua: Multimedia?
    
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
        case multimediua
    }
}
