//
//  NYTMovies.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//

import Foundation

public enum NYTMoviesErrorType: Error {
    case invalidEndpointFormat
    case invalidParameters
    case noResponseData
    case generalNetworkError
    case invalidDataResponseFormat
    case noNetworkConnection
}

public struct NYTMoviesError: LocalizedError {
    let type: NYTMoviesErrorType
    let error: Error?
    var errorDescription: String {
        switch self.type {
        case .invalidEndpointFormat:
            return "Error in creating search endpoint, possibly check your api key"
        case .invalidParameters:
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
        case .invalidDataResponseFormat:
            return "Data received from request does not match format of expect models"
        case .noNetworkConnection:
            return "Failed connecting to network, check your connection to the internet"
        }
    }
}

public class NYTMovies {
    
    let apiKey: String
    let networkInterface: NetworkInterface
    
    public init(withApiKey: String = "d31fe793adf546658bd67e2b6a7fd11a") {
        self.apiKey = withApiKey
        self.networkInterface = NetworkInterface()
    }
    
    /**
     Gets reviews that follow the provided parameters
     
     - Parameter parameters: The message to record.
     - Parameter onSuccess: The message to record.
     - Parameter reviewSearchResults: Review search results based on parameters provided
     - Parameter onFailure: Callback when network call fails
     - Parameter error: Error that occurred while attempting to get Reviews
     */
    
    public func getReviews(parameters: ReviewSearchParameters, onSuccess success: @escaping (_ reviewSearchResults: ReviewSearchResults) -> Void, onFailure failure: @escaping (_ error: NYTMoviesError) -> Void) {
        
        let queryString = try? parameters.queryString()
        
        guard let paramsAsString = queryString  else {
            failure(NYTMoviesError(type: .invalidParameters, error: nil))
            return
        }
        
        // Prefer to send in header, but NYTimes header parsing is not functioning
        // Both NYT review APIs are identical, use search.json instead of all.json to merge functionality
        let resourceTypeParameter = parameters.onlyCriticPicks ? "picks.json" : "search.json"
        let todoEndpoint: String = "https://api.nytimes.com/svc/movies/v2/reviews/\(resourceTypeParameter)?api-key=\(self.apiKey)&\(paramsAsString)"
        
        guard let url = URL(string: todoEndpoint) else {
            failure(NYTMoviesError(type: .invalidEndpointFormat, error: nil))
            return
        }
        
        self.networkInterface.request(url, onSuccess: { (responseData) in
            do {
                let resultsDecoded = try JSONDecoder().decode(ReviewSearchResults.self, from: responseData)
                success(resultsDecoded)
            }
            catch {
                failure(NYTMoviesError(type: .invalidDataResponseFormat, error: error))
                return
            }
        }, onFailure: failure)
    }
    
    public func getAllReviews(offset: Int = 0, sortOrder: SortOrder = .title, onSuccess success: @escaping (_ reviewSearchResults: ReviewSearchResults) -> Void, onFailure failure: @escaping (_ error: NYTMoviesError) -> Void) {
        var params = ReviewSearchParameters()
        params.offset = offset
        params.order = sortOrder
        self.getReviews(parameters: params, onSuccess: success, onFailure: failure)
    }
    
    public func getCriticPickedReviews(offset: Int = 0, sortOrder: SortOrder = .title, onSuccess success: @escaping (_ reviewSearchResults: ReviewSearchResults) -> Void, onFailure failure: @escaping (_ error: NYTMoviesError) -> Void) {
        var params = ReviewSearchParameters()
        params.onlyCriticPicks = true
        params.offset = offset
        params.order = sortOrder
        self.getReviews(parameters: params, onSuccess: success, onFailure: failure)
    }
    
    /**
     Gets reviews that follow the provided parameters
     
     - Parameter parameters: The message to record.
     - Parameter onSuccess: The message to record.
     - Parameter reviewSearchResults: Review search results based on parameters provided
     - Parameter onFailure: Callback when network call fails
     - Parameter error: Error that occurred while attempting to get Reviews
     */
    
    func getCritics(parameters: CriticSearchParameters, onSuccess success: @escaping (_ criticSearchResults: CriticSearchResults) -> Void, onFailure failure: @escaping (_ error: NYTMoviesError) -> Void) {

        let queryString = parameters.resourceTypeEndPoint.slugify()
        
        guard let queryEndpoint = queryString  else {
            failure(NYTMoviesError(type: .invalidParameters, error: nil))
            return
        }
        
        let todoEndpoint: String = "https://api.nytimes.com/svc/movies/v2/critics/\(queryEndpoint)?api-key=\(self.apiKey)"
        
        guard let url = URL(string: todoEndpoint) else {
            failure(NYTMoviesError(type: .invalidEndpointFormat, error: nil))
            return
        }
        
        self.networkInterface.request(url, onSuccess: { (responseData) in
            do {
                let resultsDecoded = try JSONDecoder().decode(CriticSearchResults.self, from: responseData)
                success(resultsDecoded)
            }
            catch {
                failure(NYTMoviesError(type: .invalidDataResponseFormat, error: error))
                return
            }
        }, onFailure: failure)
    }
    
    public func getAllCritics(onSuccess success: @escaping (_ criticSearchResults: CriticSearchResults) -> Void, onFailure failure: @escaping (_ error: NYTMoviesError) -> Void) {
        var params = CriticSearchParameters()
        params.subset = .all
        self.getCritics(parameters: params, onSuccess: success, onFailure: failure)
    }
    
    public func getFullTimeCritics(onSuccess success: @escaping (_ criticSearchResults: CriticSearchResults) -> Void, onFailure failure: @escaping (_ error: NYTMoviesError) -> Void) {
        var params = CriticSearchParameters()
        params.subset = .fullTime
        self.getCritics(parameters: params, onSuccess: success, onFailure: failure)
    }
    
    public func getPartTimeCritics(onSuccess success: @escaping (_ criticSearchResults: CriticSearchResults) -> Void, onFailure failure: @escaping (_ error: NYTMoviesError) -> Void) {
        var params = CriticSearchParameters()
        params.subset = .partTime
        self.getCritics(parameters: params, onSuccess: success, onFailure: failure)
    }
    
    public func getCriticByName(_ name:String, onSuccess success: @escaping (_ criticSearchResults: CriticSearchResults) -> Void, onFailure failure: @escaping (_ error: NYTMoviesError) -> Void) {
        var params = CriticSearchParameters()
        params.subset = .search
        params.searchCriticName = name
        self.getCritics(parameters: params, onSuccess: success, onFailure: failure)
    }
    
}
