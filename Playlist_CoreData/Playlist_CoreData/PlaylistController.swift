//
//  PlaylistController.swift
//  Playlist_CoreData
//
//  Created by Bethany Wride on 9/25/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation

class PLaylistController {
    // CRUD
    
    //Create
    func createPlaylist(with name: String) {
    }
    
    // Delete
    func delete(playlist: Playlist) {
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

