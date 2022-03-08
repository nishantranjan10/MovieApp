//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by NISHANT RANJAN on 2/3/22.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var noMovieView: UIView!
    
    var movieListViewModel = MovieListViewModel(moviesServices: MoviesServices())
    var searchArray : [Search]?
    var searching = false
    
    var movieName : String?
    var previousSearchText : String?
    
    var page: Int = 1
    
    var isPageRefreshing:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // To Call the MovieListApi
    func initBindingWithViewModel(movieName : String, pageNumber : String,searchedMovieName : Bool) {
        
        movieListViewModel.getMovieSearchListData(movieName: movieName, pageNumber: pageNumber, objectType: Movies.self) { (result: Result) in
            switch result {
            case .success(let object):
                
                if searchedMovieName == true {
                    self.searchArray = nil
                    self.searchArray = object.Search
                }
                else {
                    if let objectArray =  object.Search {
                        self.searchArray?.append(contentsOf: objectArray)
                    }
                }
                DispatchQueue.main.async {
                    self.setupTableFooterView()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
                self.searchArray = nil
                DispatchQueue.main.async {
                    self.setupTableFooterView()
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell") as? MovieListCell else {
            preconditionFailure("Cell not found")
        }
        cell.searchList = self.searchArray?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let search = previousSearchText, search ==  searchText {
            return
        }
        
        if searchText.count > 0 {
            movieName = searchText
            page = 1
            initBindingWithViewModel(movieName: searchText, pageNumber: "1", searchedMovieName: true)
        } else {
            searchArray = [Search]()
            setupTableFooterView(isCancel: true)
            self.tableView.reloadData()
        }
    }
    
    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool  {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searching = false
        searchBar.text = ""
        searchArray = [Search]()
        setupTableFooterView()
        self.tableView.reloadData()
    }
    
    // To call on TableView Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height)) {
            if !isPageRefreshing {
                page = page + 1
                callMovieApi(page1: page)
            }
        }
    }
    
    // call MovieApi with page Number
    func callMovieApi(page1: Int) {
        let mypage = String(page1)
        if let movieName = movieName {
            initBindingWithViewModel(movieName: movieName, pageNumber: mypage, searchedMovieName: false)
        }
    }
    
    func setupTableFooterView(isCancel: Bool? = false) {
        
        if let searchListCount = self.searchArray?.count, (searchListCount > 0 || isCancel == true){
            self.tableView.tableFooterView = .none
            noMovieView.isHidden = true
        }
        else {
            DispatchQueue.main.async {
                self.tableView.tableFooterView = self.noMovieView
                self.noMovieView.isHidden = false
            }
        }
    }
}
