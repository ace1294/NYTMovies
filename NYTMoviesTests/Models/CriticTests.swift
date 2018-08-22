//
//  CriticTests.swift
//  NYTMoviesTests
//
//  Created by Jason Dimitriou on 8/22/18.
//  Copyright © 2018 Jason Dimitriou. All rights reserved.
//

import XCTest
@testable import NYTMovies

class CriticTests: XCTestCase {
    
    func testCriticJSONDecoding() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Critic", withExtension: "json") else {
            XCTFail("Missing file: Critic.json")
            return
        }
        let data = try Data(contentsOf: url)
        
        do {
            let critic = try JSONDecoder().decode(Critic.self, from: data)
            XCTAssertEqual(critic.displayName, "A. O. Scott")
            XCTAssertEqual(critic.sortName, "A. O. Scott")
            XCTAssertEqual(critic.status, "full-time")
            XCTAssertEqual(critic.bio, "A. O. Scott joined The New York Times as a film critic in January 2000, and was named a chief critic in 2004. Previously, Mr. Scott had been the lead Sunday book reviewer for Newsday and a frequent contributor to Slate, The New York Review of Books, and many other publications. \n<br/><br/>\nIn the 1990s he served on the editorial staffs of Lingua Franca and The New York Review of Books. He also edited \"A Bolt from the Blue and Other Essays,\" a collection by Mary McCarthy, which was published by The New York Review of Books in 2002. \n<br/><br/>\nMr. Scott was a finalist for the Pulitzer Prize in Criticism in 2010, the same year he served as co-host (with Michael Phillips of the Chicago Tribune) on the last season of \"At the Movies,\" the syndicated film-reviewing program started by Roger Ebert and Gene Siskel.\n<br/><br/>\nA frequent presence on radio and television, Mr. Scott is Distinguished Professor of Film Criticism at Wesleyan University and the author of Better Living Through Criticism, forthcoming in 2016 from The Penguin Press. A collection of his film writing will be published by Penguin in 2017. \n<br/><br/>\nHe lives in Brooklyn with his family.")
            XCTAssertEqual(critic.seoName, "A-O-Scott")
            XCTAssertEqual(critic.multimedia?.type, "image")
            XCTAssertEqual(critic.multimedia?.src, "http://static01.nyt.com/images/2015/10/07/topics/ao-scott/ao-scott-articleInline.jpg")
            XCTAssertEqual(critic.multimedia?.height, 163)
            XCTAssertEqual(critic.multimedia?.width, 220)
            XCTAssertEqual(critic.multimedia?.credit, "Earl Wilson/<br/>The New York Times")
        }
        catch {
            XCTFail("Failed parsing Critic object")
            return
        }
    }
    
    func testCriticSearchResultsJSONDecoding() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "CriticSearchResults", withExtension: "json") else {
            XCTFail("Missing file: CriticSearchResults.json")
            return
        }
        let data = try Data(contentsOf: url)
        
        do {
            let searchResults = try JSONDecoder().decode(CriticSearchResults.self, from: data)
            XCTAssertEqual(searchResults.status, "OK")
            XCTAssertEqual(searchResults.copyright, "Copyright (c) 2018 The New York Times Company. All Rights Reserved.")
            XCTAssertEqual(searchResults.numResults, 3)
            XCTAssertEqual(searchResults.critics.count, 3)
        }
        catch {
            XCTFail("Failed parsing Critic object")
            return
        }
    }
    
}
