//
//  PlaylistDetailTableViewController.swift
//  Playlist_CoreData
//
//  Created by Bethany Wride on 9/25/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class PlaylistDetailTableViewController: UITableViewController {
    
    // Receiver
    var playlistToReceive: Playlist?
   
    // MARK: - Outlets
    @IBOutlet weak var songNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = playlistToReceive?.playlistName
    }
    
    // MARK: - Actions
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let playlist = playlistToReceive,
            let songName = songNameTextField.text,
            let artistName = artistNameTextField.text,
            !songName.isEmpty,
            !artistName.isEmpty
            else { return }
        SongController.createSong(with: songName, artistName: artistName, to: playlist)
        
        // Reset
        songNameTextField.text = ""
        artistNameTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlistToReceive?.songs?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        guard let unwrappedPlaylist = playlistToReceive, let song = unwrappedPlaylist.songs?[indexPath.row] as? Song
            else { return UITableViewCell() }
//        let song = playlist?.songs?[indexPath.row]
        cell.textLabel?.text = song.songName
        cell.detailTextLabel?.text = song.artistName
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlistToReceive, let song = playlist.songs?[indexPath.row] as? Song
            else { return }
            SongController.delete(song: song)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
