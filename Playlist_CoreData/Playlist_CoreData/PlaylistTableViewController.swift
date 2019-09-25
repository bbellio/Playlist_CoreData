//
//  PlaylistTableViewController.swift
//  Playlist_CoreData
//
//  Created by Bethany Wride on 9/25/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var playlistNameTextField: UITextField!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Action
    @IBAction func addPlaylistButtonTapped(_ sender: Any) {
        guard let name = playlistNameTextField.text,
            !name.isEmpty else { return }
        PlaylistController.sharedInstance.createPlaylist(with: name)
        // Reset
        playlistNameTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.sharedInstance.playlists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
        let songCount = playlist.songs?.count ?? 0
        cell.textLabel?.text = playlist.playlistName
        cell.detailTextLabel?.text = "\(songCount)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlistToDelete = PlaylistController.sharedInstance.playlists[indexPath.row]
            PlaylistController.sharedInstance.delete(playlist: playlistToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let indexPathForTappedCell = tableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? PlaylistDetailTableViewController else { return }
                let playlistToSend = PlaylistController.sharedInstance.playlists[indexPathForTappedCell.row]
                destinationVC.playlistToReceive = playlistToSend
            }
        }
    }
} // End of class
 
