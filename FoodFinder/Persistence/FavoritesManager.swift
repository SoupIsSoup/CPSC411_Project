//****************************************************************************************************************************
//Program name: "FavoritesManager.swift".  This file manages storage of favorite restaurants using SQLite.                  *
//It provides functionality to create the database, insert favorite restaurants, and retrieve saved data.                  *
//Copyright (C) 2026  Jake Miso                                                                                              *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                          *
//****************************************************************************************************************************




//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2**
//Author information
//  Author name: Jake Miso
//  Author email: jamiso@csu.fullerton.edu
//
//Program information
//  Program name: FoodFinder
//  Programming language: Swift
//  Date development of program began 2026-Apr-28
//  Date development of program completed TBD
//
//Purpose
//  Store and retrieve favorite restaurants locally using SQLite.  This file handles database creation,
//  insertion of new favorites, and retrieval of saved favorites.
//
//Project information
//  Files: FoodFinderApp.swift, ContentView.swift, RestaurantListView.swift, RestaurantDetailView.swift,
//         Restaurant.swift, YelpResponse.swift, YelpService.swift, FavoritesManager.swift, Secrets.swift,
//         Secrets.example.swift
//  Status: In development.
//
//Translator information
//  Apple macOS: Xcode with Swift compiler
//
//References and credits
//  CPSC 411 course examples
//  SQLite.swift documentation
//
//Format information
//  Page width: 172 columns
//  Begin comments: 61
//  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
//
//===== Begin code area ====================================================================================================================================================

import Foundation                                              //Import Foundation for file system access
import SQLite                                                  //Import SQLite.swift package for database functionality

//==========================================================================================================================================================================
//===== FavoritesManager class =============================================================================================================================================
//==========================================================================================================================================================================

final class FavoritesManager {                                 //Begin FavoritesManager class

    //======================================================================================================================================================================
    //===== Stored properties ==============================================================================================================================================
    //======================================================================================================================================================================

    private let db: Connection                                 //SQLite database connection
    private let favorites = Table("favorites")                 //Favorites table

    private let id = Expression<Int64>("id")                   //Primary key column
    private let name = Expression<String>("name")              //Restaurant name column
    private let category = Expression<String>("category")      //Restaurant category column

    //======================================================================================================================================================================
    //===== Initialization ================================================================================================================================================
    //======================================================================================================================================================================
    //  This initializer creates or opens the SQLite database file and ensures the favorites table exists.
    //======================================================================================================================================================================

    init() throws {

        // Create path to database file in the app's Documents directory
        let url = try FileManager.default
            .url(for: .documentDirectory,
                 in: .userDomainMask,
                 appropriateFor: nil,
                 create: true)
            .appendingPathComponent("favorites.sqlite3")

        db = try Connection(url.path)                          //Establish connection to database file

        // Create favorites table if it does not already exist
        try db.run(favorites.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)           //Auto-increment primary key
            t.column(name)                                     //Restaurant name column
            t.column(category)                                 //Category column
        })
    }

    //======================================================================================================================================================================
    //===== Add favorite function =========================================================================================================================================
//======================================================================================================================================================================
    //  Inserts a new favorite restaurant into the database.
    //======================================================================================================================================================================

    func addFavorite(name: String, category: String) throws {

        let insert = favorites.insert(self.name <- name,
                                      self.category <- category)

        try db.run(insert)                                     //Execute insert statement
    }

    //======================================================================================================================================================================
    //===== Get favorites function =========================================================================================================================================
//======================================================================================================================================================================
    //  Retrieves all favorite restaurants from the database and returns them as formatted strings.
    //======================================================================================================================================================================

    func getFavorites() throws -> [String] {

        try db.prepare(favorites).map { row in                 //Query all rows in favorites table
            "\(row[name]) - \(row[category])"                 //Format result string
        }
    }
}


