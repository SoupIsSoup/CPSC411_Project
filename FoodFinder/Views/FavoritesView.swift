//****************************************************************************************************************************
//Program name: "FavoritesView.swift".  This file displays the users' favorited restaurants.                               *
//It is presented by selecting the Favorites button.  Copyright (C) 2026  Jake Miso                                        *
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
//  Display a list of restaurants favorited by the user.
//
//
//Project information
//  Files: FoodFinderApp.swift, ContentView.swift, RestaurantListView.swift, RestaurantDetailView.swift,
//         Restaurant.swift, YelpResponse.swift, YelpService.swift, Secrets.swift, Secrets.example.swift
//  Status: In development.
//
//===== Begin code area ====================================================================================================================================================

import SwiftUI

struct FavoritesView: View {
    
    @State private var favorites: [String] = []
    let category: String
    
    var body: some View{
        
        List(favorites, id: \.self) { favorite in                     //Creates scrollable list
            let parts = favorite.split(separator: " - ", maxSplits: 1)   //Splits the string with '-' as the separator (since that's how it's formatted in FavoritesManager) into the parts substring array
            VStack(alignment: .leading) {
                Text(parts.first.map(String.init) ?? "Unknown")   //sets the first element of the parts substring array (which should be the restaurant name) as a full string
                    .font(.headline)
                Text(parts.count > 1 ? String(parts[1]) : "No Category") //checks if there is a second part after the split, sets the second part of the parts substring as the category in the case that the restaurant namae has '-'
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {                             //runs when the view is on the screen
            do {
                let manager = try FavoritesManager()        //attempts to create a new favoritesManager() instance
                favorites = try manager.getFavorites()      //attempts to call getFavorites()
            } catch {
                print("Failed to load favorites: \(error)")
            }
        }
    }
}
