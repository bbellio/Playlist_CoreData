//
//  SongController.swift
//  Playlist_CoreData
//
//  Created by Bethany Wride on 9/25/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation
import CoreData

class SongController {
    
    // CRUD
    // Create
    static func createSong(with songName: String, artistName: String, to playlist: Playlist) {
        Song(songName: songName, artistName: artistName, playlist: playlist)
        PlaylistController.sharedInstance.saveToPersistentStore()
    }
    
    // Delete
    static func delete(song: Song) {
        CoreDataStack.context.delete(song)
        PlaylistController.sharedInstance.saveToPersistentStore()
    }
}
