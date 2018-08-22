//
//  CriticSearchViewController.swift
//  NYTMoviesExample
//
//  Created by Jason Dimitriou on 8/22/18.
//  Copyright © 2018 Jason Dimitriou. All rights reserved.
//

import UIKit
import NYTMovies

class CriticSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var critics: [Critic] = []
    let moviesAPI = NYTMovies()
    var totalOffset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.showAllCriticss()
    }
    
    func searchCriticsForString(_ searchString: String) {
        weak var weakSelf = self
        self.moviesAPI.getCriticByName(searchString, onSuccess: { (searchResults) in
            weakSelf?.critics = searchResults.critics
            DispatchQueue.main.async {
                weakSelf?.tableView.reloadData()
            }
        }) { (error) in
            print("Error searching for critic", searchString, error)
        }
    }
    
    func showAllCriticss() {
        weak var weakSelf = self
        self.moviesAPI.getFullTimeCritics(onSuccess: { (searchResults) in
            weakSelf?.critics = searchResults.critics
            DispatchQueue.main.async {
                weakSelf?.tableView.reloadData()
            }
        }) { (error) in
            print("Error searching for all critics", error)
        }
    }
    
}

extension CriticSearchViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table View Delegate and Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.critics.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"CellIdentifier", for: indexPath) as UITableViewCell
        
        let critic = self.critics[indexPath.row]
        
        cell.textLabel?.text = critic.displayName
        cell.detailTextLabel?.text = critic.status
        
        return cell
    }
}

extension CriticSearchViewController: UISearchBarDelegate {
    // MARK: - UISearchResultsUpdating Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Only search text every half second, cancle previous request if there is one
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reloadSearchText), object: nil)
        self.perform(#selector(self.reloadSearchText), with: nil, afterDelay: 0.5)
    }
    
    @objc func reloadSearchText() {
        if let searchText = self.searchBar.text {
            if searchText.count > 0 {
                self.searchCriticsForString(searchText)
            }
            else {
                self.showAllCriticss()
            }
        }
    }
}
