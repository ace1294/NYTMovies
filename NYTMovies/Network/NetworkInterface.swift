//
//  NetworkInterface.swift
//  NYTMovies
//
//  Created by Jason Dimitriou on 8/21/18.
//  Copyright © 2018 Jason Dimitriou. All rights reserved.
//

import Foundation

class NetworkInterface {
    
    var isNetworkReachable: Bool = true
    var cache: [String: Data] = [:]
    
    init() {
        self.checkNetworkReachability()
    }
    
    func request(_ url: URL, onSuccess success: @escaping (_ data: Data) -> Void, onFailure failure: @escaping (_ error: NYTMoviesError) -> Void) {
        
        if let cachedData = self.cache[url.absoluteString] {
            success(cachedData)
            return
        }
        
        if !self.isNetworkReachable {
            failure(NYTMoviesError(type: .noNetworkConnection, error: nil))
            return
        }
        
        // Using URLSession instead of Alamofire to cut down on dependencies
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, networkError) in
            
            if let err = networkError {
                failure(NYTMoviesError(type: .generalNetworkError, error: err))
                return
            }
            
            guard let responseData = data else {
                failure(NYTMoviesError(type: .noResponseData, error: nil))
                return
            }
            
            self.cache[url.absoluteString] = responseData
            
            success(responseData)
        }
        task.resume()
    }
    
    private func checkNetworkReachability()
    {
        // Uses local swift networking library instead of depedency on Reachability
        weak var weakSelf = self
        self.checkNetwork( {(isReachable:Bool) -> Void in
            weakSelf?.isNetworkReachable = isReachable
        })
    }
    
    func checkNetwork(_ completionHandler:@escaping (_ internet:Bool) -> Void)
    {
        // Hit the endpoint the framework needs
        guard let url = URL(string: "https://www.nytimes.com/") else {
            completionHandler(false)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        // Just check head, less data to load
        urlRequest.httpMethod = "HEAD"
        urlRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        urlRequest.timeoutInterval = 5.0
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                completionHandler((httpResponse.statusCode == 200))
            }
            else {
                completionHandler(false)
            }
        }
        task.resume()
    }
    
}
