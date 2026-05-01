//****************************************************************************************************************************
//Program name: "FavoritesView.swift".  This file displays favorite restaurants saved locally using SQLite only after the    *
//user presses the refresh button.  Copyright (C) 2026  Jake Miso                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                          *
//****************************************************************************************************************************




//===== Begin code area ====================================================================================================================================================

import SwiftUI                                                //Import SwiftUI framework for building user interface

//==========================================================================================================================================================================
//===== FavoritesView structure ============================================================================================================================================
//==========================================================================================================================================================================

struct FavoritesView: View {                                  //Define the FavoritesView structure

    @State private var favorites: [String] = []                //Start favorites list empty when screen opens
    @State private var statusMessage: String = ""             //Start status message empty when screen opens

    var body: some View {                                      //Define the user interface layout

        VStack(spacing: 16) {                                  //Create vertical stack layout

            Text("Favorite Restaurants")                       //Display title text
                .font(.largeTitle)                             //Set font size to large title
                .fontWeight(.bold)                             //Make title bold

            Button("Refresh Favorites") {                      //Create button to load favorites manually
                loadFavorites()                                //Call loadFavorites function when pressed
            }
            .padding()                                         //Add spacing around button
            .background(Color.blue)                            //Set button background color
            .foregroundColor(.white)                           //Set button text color
            .cornerRadius(8)                                   //Round button corners

            Text(statusMessage)                                //Display current status message
                .font(.subheadline)                            //Set font size
                .foregroundColor(.gray)                        //Set text color

            if favorites.isEmpty {                             //Check if favorites list is empty

                Text("No favorites loaded.")                    //Display message when nothing is loaded
                    .foregroundColor(.secondary)               //Set text color

                Spacer()                                       //Push content upward

            } else {                                           //If favorites exist

                List(favorites, id: \.self) { favorite in       //Create list for each favorite string

                    Text(favorite)                             //Display each favorite restaurant
                        .font(.body)                           //Set font size
                        .padding(.vertical, 4)                 //Add vertical spacing inside list row
                }
            }
        }
        .padding()                                             //Add padding to entire view
        .navigationTitle("Favorites")                          //Set navigation title
    }

    //======================================================================================================================================================================
    //===== Load favorites function ========================================================================================================================================
    //======================================================================================================================================================================

    private func loadFavorites() {                             //Begin function

        do {                                                   //Begin error handling

            let manager = try FavoritesManager()               //Create database manager

            let savedFavorites = try manager.getFavorites()    //Retrieve favorites from database

            favorites = savedFavorites                         //Store results in state variable

            statusMessage = "Loaded \(savedFavorites.count) favorites" //Update status message

        } catch {                                              //Handle errors

            favorites = []                                     //Clear favorites list

            statusMessage = "Error loading favorites"          //Display error message

            print("Favorites loading error:", error)           //Print error to console
        }
    }
}


