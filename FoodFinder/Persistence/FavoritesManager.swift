//****************************************************************************************************************************
//Program name: "FavoritesManager.swift".  This file manages storage of favorite restaurants using SQLite.                  *
//It creates the database, inserts favorite restaurants, and retrieves saved favorites.                                     *
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
//  Store and retrieve favorite restaurants locally using SQLite database.
//
//Project information
//  Files: FoodFinderApp.swift, ContentView.swift, RestaurantListView.swift, RestaurantDetailView.swift,
//         FavoritesView.swift, Restaurant.swift, YelpResponse.swift, YelpService.swift, FavoritesManager.swift,
//         Secrets.swift, Secrets.example.swift
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

import Foundation                                             //Import Foundation for file handling and system paths
import SQLite                                                 //Import SQLite.swift package for database operations

//==========================================================================================================================================================================
//===== FavoritesManager class =============================================================================================================================================
//==========================================================================================================================================================================

final class FavoritesManager {                                //Define the FavoritesManager class

    //======================================================================================================================================================================
    //===== Stored properties ==============================================================================================================================================
    //======================================================================================================================================================================

    private let db: Connection                                //SQLite database connection object
    private let favorites = Table("favorites")                //Define the "favorites" table

    private let id = Expression<Int64>("id")                  //Define primary key column
    private let name = Expression<String>("name")             //Define restaurant name column
    private let category = Expression<String>("category")     //Define category column

    //======================================================================================================================================================================
    //===== Initialization ================================================================================================================================================
    //======================================================================================================================================================================
    //  This initializer creates or opens the SQLite database file and ensures the favorites table exists.
    //======================================================================================================================================================================

    init() throws {                                           //Initializer that may throw errors

        let url = try FileManager.default                     //Access file manager
            .url(for: .documentDirectory,                     //Get documents directory
                 in: .userDomainMask,                         //User domain
                 appropriateFor: nil,                         //No specific file
                 create: true)                                //Create directory if needed
            .appendingPathComponent("favorites.sqlite3")      //Append database file name

        db = try Connection(url.path)                         //Create SQLite connection

        try db.run(favorites.create(ifNotExists: true) { t in //Create table if it does not exist
            t.column(id, primaryKey: .autoincrement)          //Create auto-increment primary key
            t.column(name)                                    //Create name column
            t.column(category)                                //Create category column
        })
    }

    //======================================================================================================================================================================
    //===== Add favorite function =========================================================================================================================================
//======================================================================================================================================================================
    //  Inserts a new favorite restaurant into the database.
    //======================================================================================================================================================================

    func addFavorite(name: String, category: String) throws { //Function to insert favorite

        let insert = favorites.insert(                        //Create insert statement
            self.name <- name,                                //Set name column value
            self.category <- category                         //Set category column value
        )

        try db.run(insert)                                    //Execute insert query
    }

    //======================================================================================================================================================================
    //===== Get favorites function =========================================================================================================================================
//======================================================================================================================================================================
    //  Retrieves all favorite restaurants from the database.
    //======================================================================================================================================================================

    func getFavorites() throws -> [String] {                  //Function to retrieve favorites

        try db.prepare(favorites).map { row in               //Query all rows in favorites table
            "\(row[name]) - \(row[category])"               //Format each row into string
        }
    }
}

