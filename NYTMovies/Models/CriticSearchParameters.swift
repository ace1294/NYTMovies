//
//  CriticSearchParamters.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//  Copyright © 2018 Jason Dimitriou. All rights reserved.
//

import Foundation

enum CriticsSubset: String {
    case all = "all.json"
    case fullTime = "full-time.json"
    case partTime = "part-time.json"
    case search = "search"
}

struct CriticSearchParameters {
    var subset: CriticsSubset = .all
    var searchCriticName: String?
    
    var resourceTypeEndPoint: String {
        get {
            if let critic = searchCriticName {
                return "\(critic).json"
            }
            else {
                return subset.rawValue
            }
        }
    }
}
