//****************************************************************************************************************************
//Program name: "RestaurantDetailView.swift".  This file displays detailed information about a selected restaurant and      *
//allows the user to save the restaurant as a favorite using SQLite.                                                        *
//Copyright (C) 2026  Jake Miso                                                                                              *
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
//  Display detailed restaurant information and allow the user to save the restaurant to favorites.
//
//Project information
//  Files: FoodFinderApp.swift, ContentView.swift, RestaurantListView.swift, RestaurantDetailView.swift,
//         Restaurant.swift, YelpResponse.swift, YelpService.swift, FavoritesManager.swift, Secrets.swift,
//         Secrets.example.swift
//  Status: In development.
//
//===== Begin code area ====================================================================================================================================================

import SwiftUI                                            //Import SwiftUI framework for UI components

//==========================================================================================================================================================================
//===== RestaurantDetailView structure =====================================================================================================================================
//==========================================================================================================================================================================

struct RestaurantDetailView: View {                        //Define the detail view structure

    let restaurant: Restaurant                             //Store the selected restaurant passed from the list view

    @State private var statusMessage: String = ""          //Store message shown to user after saving favorite

    //======================================================================================================================================================================
    //===== Body ==========================================================================================================================================================
//======================================================================================================================================================================

    var body: some View {                                  //Define UI layout

        VStack(alignment: .leading, spacing: 16) {          //Create vertical stack for layout

            Text(restaurant.name)                           //Display restaurant name
                .font(.largeTitle)                          //Set font size to large title
                .fontWeight(.bold)                          //Make text bold

            Text("Rating: \(restaurant.rating ?? 0.0)")     //Display rating or 0.0 if nil
                .font(.title2)                              //Set font size

            Text("Price: \(restaurant.price ?? "N/A")")     //Display price or fallback
                .font(.title3)                              //Set font size

            Text("Phone: \(restaurant.phone ?? "N/A")")     //Display phone or fallback

            Text("Address: \(formatAddress())")             //Display formatted address

            //==================================================
            // Add to Favorites Button
            //==================================================

            Button("Add to Favorites") {                    //Create button for saving favorite
                addToFavorites()                            //Call function when button is pressed
            }
            .padding()                                     //Add spacing around button
            .background(Color.blue)                         //Set button background color
            .foregroundColor(.white)                        //Set text color
            .cornerRadius(8)                                //Round button corners

            Text(statusMessage)                             //Display status message
                .foregroundColor(.green)                    //Set message color

            Spacer()                                        //Push content upward
        }
        .padding()                                          //Add padding to entire view
        .navigationTitle("Details")                          //Set navigation bar title
    }

    //======================================================================================================================================================================
    //===== Add to Favorites ==============================================================================================================================================
//======================================================================================================================================================================

    private func addToFavorites() {                          //Function to save restaurant

        do {                                                 //Begin try-catch block

            let manager = try FavoritesManager()             //Create database manager

            let category = restaurant.price ?? "unknown"     //Use price as category placeholder

            try manager.addFavorite(name: restaurant.name,   //Insert restaurant name
                                    category: category)     //Insert category value

            statusMessage = "Saved to favorites!"            //Update success message

        } catch {                                            //Catch any errors

            statusMessage = "Error saving favorite"          //Update failure message
            print(error)                                     //Print error to console
        }
    }

    //======================================================================================================================================================================
    //===== Address formatter =============================================================================================================================================
//======================================================================================================================================================================

    private func formatAddress() -> String {                 //Function to build address string

        guard let location = restaurant.location else {      //Check if location exists
            return "Address not available"                   //Return fallback if nil
        }

        let street = location.address1 ?? ""                 //Get street or empty string
        let city = location.city ?? ""                       //Get city or empty string
        let state = location.state ?? ""                     //Get state or empty string

        return "\(street), \(city), \(state)"               //Return formatted address
    }
}


