//
//  MoviesListTableViewController.swift
//  Test task movies
//
//  Created by Vova on 15.04.2022.
//

import UIKit

final class MoviesListTableViewController: UITableViewController {
    
    private let identifier: String = "MoviesListCell"
    private var movies: [Result] = []
    private let urlAdress = "https://api.themoviedb.org/3/movie/popular?api_key=cc0e0b8489686997f95da4100f4cb511&language=en-US&page=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        tableView.addGestureRecognizer(longPress)
        
        NetworkManager.shared.fetchDataNews(url: urlAdress) { movies in
            guard let movies = movies?.results else { return }
            self.movies = movies
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MoviesListTableViewCell{
            cell.refresh(movies[indexPath.row])
            cell.configure(movies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - Handle Long Press
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                FavoritesListTableViewController.favoritesArray.insert(movies[indexPath.row], at: 0)
                FavoritesListTableViewController.favoritesArray = FavoritesListTableViewController.favoritesArray.uniqued()
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let movieInformationViewController = segue.destination as! MovieInformationViewController
                movieInformationViewController.movie = movies[indexPath.row]
            }
        }
    }
}
// MARK: - Extension
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
