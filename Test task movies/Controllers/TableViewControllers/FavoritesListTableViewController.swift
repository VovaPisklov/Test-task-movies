//
//  FavoritesListTableViewController.swift
//  Test task movies
//
//  Created by Vova on 15.04.2022.
//

import UIKit

final class FavoritesListTableViewController: UITableViewController {
    
    private let identifier: String = "FavoritesListCell"
    static var favoritesArray: [Result] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoritesListTableViewController.favoritesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavoritesListTableViewCell{
            cell.refresh(FavoritesListTableViewController.favoritesArray[indexPath.row])
            cell.configure(FavoritesListTableViewController.favoritesArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FavoritesListTableViewController.favoritesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
            
        } else if editingStyle == .insert {
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let movieInformationViewController = segue.destination as! MovieInformationViewController
                movieInformationViewController.movie = FavoritesListTableViewController.favoritesArray[indexPath.row]
            }
        }
    }
}
