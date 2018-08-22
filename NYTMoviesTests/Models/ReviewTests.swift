//
//  ReviewTests.swift
//  NYTMoviesTests
//
//  Created by Jason Dimitriou on 8/22/18.
//  Copyright © 2018 Jason Dimitriou. All rights reserved.
//

import XCTest
@testable import NYTMovies

class ReviewTests: XCTestCase {
    
    func testCriticJSONDecoding() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Review", withExtension: "json") else {
            XCTFail("Missing file: Review.json")
            return
        }
        let data = try Data(contentsOf: url)
        
        do {
            let review = try JSONDecoder().decode(Review.self, from: data)
            XCTAssertEqual(review.displayTitle, "The Happytime Murders")
            XCTAssertEqual(review.mpaaRating, "R")
            XCTAssertEqual(review.criticsPick, 0)
            XCTAssertEqual(review.byLine, "A.O. SCOTT")
            XCTAssertEqual(review.headline, "Review: ‘The Happytime Murders’ Has Puppets as Nasty as the Rest of Us")
            XCTAssertEqual(review.summaryShort, "Melissa McCarthy and Elizabeth Banks are part of a human cast trading jokes, bullets and bodily fluids with anthropomorphic, felt-covered toys.")
            XCTAssertEqual(review.publicationDate, "2018-08-22")
            XCTAssertEqual(review.openingDate, "2018-08-24")
            XCTAssertEqual(review.dateUpdated, "2018-08-22 21:04:02")
            XCTAssertEqual(review.link.type, "article")
            XCTAssertEqual(review.link.url, "http://www.nytimes.com/2018/08/22/movies/the-happytime-murders-review-melissa-mccarthy.html")
            XCTAssertEqual(review.link.suggestedLinkText, "Read the New York Times Review of The Happytime Murders")
            XCTAssertEqual(review.multimedia?.type, "mediumThreeByTwo210")
            XCTAssertEqual(review.multimedia?.src, "https://static01.nyt.com/images/2018/08/24/arts/24happytime/merlin_142506798_05284e57-b669-4e74-97c0-f6e920b186c0-mediumThreeByTwo210.jpg")
            XCTAssertEqual(review.multimedia?.height, 140)
            XCTAssertEqual(review.multimedia?.width, 210)
            XCTAssertEqual(review.multimedia?.credit, nil)
            
        }
        catch {
            XCTFail("Failed parsing Critic object")
            return
        }
    }
    
    func testReviewSearchResultsJSONDecoding() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "ReviewSearchResults", withExtension: "json") else {
            XCTFail("Missing file: ReviewSearchResults.json")
            return
        }
        let data = try Data(contentsOf: url)
        
        do {
            let searchResults = try JSONDecoder().decode(ReviewSearchResults.self, from: data)
            XCTAssertEqual(searchResults.status, "OK")
            XCTAssertEqual(searchResults.copyright, "Copyright (c) 2018 The New York Times Company. All Rights Reserved.")
            XCTAssertEqual(searchResults.hasMore, true)
            XCTAssertEqual(searchResults.numResults, 20)
            XCTAssertEqual(searchResults.reviews.count, 20)
        }
        catch {
            XCTFail("Failed parsing Critic object")
            return
        }
    }
    
}
