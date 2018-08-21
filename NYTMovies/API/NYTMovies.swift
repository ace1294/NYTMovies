//
//  NYTMovies.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

enum NYTMoviesErrorType: Error {
    case failedEndpointFormat
    case failedParameters
    case noResponseData
    case generalNetworkError
    case improperDataResponseFormat
}

struct NYTMoviesError: LocalizedError {
    let type: NYTMoviesErrorType
    let error: Error?
    var errorDescription: String {
        switch self.type {
        case .failedEndpointFormat:
            return "Error in creating search endpoint, possibly check your api key"
        case .failedParameters:
            return "Error in encoding SearchParameters object into http body"
        case .noResponseData:
            return "No response data with given SearchParameters"
        case .generalNetworkError:
            if let err = error {
                return err.localizedDescription
            }
            else {
                return "General network error has occured without description"
            }
        case .improperDataResponseFormat:
            return "Data received from request does not match format of expect models"
        }
    }
}


struct test {
    let a: Int
    private var b: Int?
}

class NYTMovies {
    
    let apiKey: String
    
    init(withApiKey: String = "d31fe793adf546658bd67e2b6a7fd11a") {
        self.apiKey = withApiKey
    }
    
    func getReviews(parameters: SearchParameters, onSuccess success: @escaping (_ reviewSearchResults: ReviewSearchResults) -> Void, onFailure failure: @escaping (_ error: NYTMoviesError) -> Void) {
        
        let todoEndpoint: String = "https://api.nytimes.com/svc/movies/v2/reviews/all.json"
        guard let url = URL(string: todoEndpoint) else {
            failure(NYTMoviesError(type: .failedEndpointFormat, error: nil))
            return
        }
        
        var urlRequest = URLRequest(url: url)

        let jsonData = try? JSONEncoder().encode(parameters)
        
        guard let httpJsonData = jsonData else {
            failure(NYTMoviesError(type: .failedParameters, error: nil))
            return
        }
        
        urlRequest.httpBody = httpJsonData
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            
            if let networkError = error {
                failure(NYTMoviesError(type: .generalNetworkError, error: networkError))
                return
            }
            
            guard let responseData = data else {
                failure(NYTMoviesError(type: .noResponseData, error: nil))
                return
            }
            
            let resultsDecoded = try? JSONDecoder().decode(ReviewSearchResults.self, from: responseData)
            
            guard let reviewSearchResults = resultsDecoded else {
                // FAILED PARAMETERS
                failure(NYTMoviesError(type: .improperDataResponseFormat, error: nil))
                return
            }
            
            success(reviewSearchResults)
        }
        task.resume()
    }
    
}
