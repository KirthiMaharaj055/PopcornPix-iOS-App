//
//  MovieTableViewController.swift
//  PopcornPix-App
//
//  Created by Kirthi Maharaj on 2024/08/27.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    @IBOutlet weak var movieSerach: UISearchBar!
    
    let movieService = MovieService()
    var filteredMoviesList = [Movies]()
    
    var moviesList = [Movies]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "PopcornPix"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        movieSerach.delegate = self
        
        getAllMovieList()
        tableView.dataSource = self
        tableView.delegate = self
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func getAllMovieList(){
        movieService.fetchAllMoviesApi{ [weak self] movies in
            
            switch movies {
            case .success(let successMovie):
                print(successMovie)
                self?.moviesList = successMovie
                self?.filteredMoviesList = successMovie
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredMoviesList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        cell.configure(withInfo: self.filteredMoviesList[indexPath.row])
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailViewController{
            //destination.movies = moviesList[(tableView.indexPathForSelectedRow?.row)!]
            destination.movieID = filteredMoviesList[(tableView.indexPathForSelectedRow?.row)!].id

        }
    }

}

extension MovieTableViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                filteredMoviesList = moviesList
            } else {
                filteredMoviesList = moviesList.filter { movie in
                    movie.title.localizedCaseInsensitiveContains(searchText)
                }
            }
            tableView.reloadData()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder() // Dismiss the keyboard when the search button is clicked
        }
}
