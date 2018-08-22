//
//  ViewController.swift
//  NYTMoviesExample
//
//  Created by Jason Dimitriou on 8/21/18.
//  Copyright © 2018 Jason Dimitriou. All rights reserved.
//

import UIKit
import NYTMovies

class ReviewSearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var reviews: [Review] = []
    let moviesAPI = NYTMovies()
    var totalOffset = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.showAllReviews()
    }
    
    func searchReviewsForString(_ searchString: String) {
        var searchParams = ReviewSearchParameters()
        searchParams.query = searchString
        searchParams.openingStartDate = "1991-04-10"
        searchParams.openingEndDate = "2000-05-12"
        weak var weakSelf = self
        self.moviesAPI.getReviews(parameters: searchParams, onSuccess: { (searchResults) in
            weakSelf?.reviews = searchResults.reviews
            DispatchQueue.main.async {
                weakSelf?.tableView.reloadData()
            }
        }) { (error) in
            print("Error searching for", searchString, error)
        }
    }
    
    func showAllReviews() {
        weak var weakSelf = self
        self.moviesAPI.getAllReviews(onSuccess: { (searchResults) in
            weakSelf?.reviews = searchResults.reviews
            DispatchQueue.main.async {
                weakSelf?.tableView.reloadData()
            }
        }) { (error) in
            print("Error searching for all reviews", error)
        }
    }

}

extension ReviewSearchViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table View Delegate and Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"CellIdentifier", for: indexPath) as UITableViewCell
        
        let review = self.reviews[indexPath.row]
        
        cell.textLabel?.text = review.displayTitle
        cell.detailTextLabel?.text = review.headline
        
        return cell
    }
}

extension ReviewSearchViewController: UISearchBarDelegate {
    // MARK: - UISearchResultsUpdating Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Only search text every half second, cancle previous request if there is one
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reloadSearchText), object: nil)
        self.perform(#selector(self.reloadSearchText), with: nil, afterDelay: 0.5)
    }
    
    @objc func reloadSearchText() {
        if let searchText = self.searchBar.text {
            if searchText.count > 0 {
                self.searchReviewsForString(searchText)
            }
            else {
                self.showAllReviews()
            }
        }
    }
}

