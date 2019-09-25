//
//  PlaylistController.swift
//  Playlist_CoreData
//
//  Created by Bethany Wride on 9/25/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation
import CoreData

class PlaylistController {
    
    // Singleton
    static let sharedInstance = PlaylistController()
    // Local source of truth (data actually stored in persistent store)
    var playlists: [Playlist] {
        // Creat fetch request
        let fetchRequest: NSFetchRequest<Playlist> = Playlist.fetchRequest()
        // Return outcome of fetch request or return an empty array (doesn't have to be a do catch block because we guarantee a value will be returned either way - either empty or the success fetch request)
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    // CRUD
    //Create
    func createPlaylist(with name: String) {
        _ = Playlist(playlistName: name)
        saveToPersistentStore()
    }
    
    // Delete
    func delete(playlist: Playlist) {
        CoreDataStack.context.delete(playlist)
        saveToPersistentStore()
    }
    
    // Save
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
} // End of class

